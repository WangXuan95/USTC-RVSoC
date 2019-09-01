module core_top(
    input  logic clk, rst_n,
    input  logic [31:0] i_boot_addr,
    naive_bus.master  instr_master, data_master
);
// ID stage
logic [31:0] id_instr, id_pc;
logic id_src1_reg_en, id_src2_reg_en;
logic [ 4:0] id_src1_reg_addr, id_src2_reg_addr, id_dst_reg_addr;
logic id_jal, id_alures2reg, id_memory2reg, id_memwrite;
logic [ 6:0] id_opcode, id_funct7;
logic [ 2:0] id_funct3;
logic [31:0] id_imm;

// EX stage
logic ex_branch_jalr, ex_alures2reg=1'b0, ex_memory2reg=1'b0, ex_memwrite=1'b0;
logic [6:0]  ex_opcode=7'h0, ex_funct7=7'h0;
logic [2:0]  ex_funct3=3'h0;
logic [4:0]  ex_dst_reg_addr=5'h0;
logic [31:0] ex_alu_res, ex_src1_reg_data, ex_src2_reg_data, ex_pc=0, ex_imm=0, ex_branch_jalr_target;

// MEM stage
logic [2:0]  mem_funct3=3'b0;
logic mem_alures2reg=1'b0, mem_memory2reg=1'b0, mem_memwrite=1'b0;
logic [31:0] mem_alu_res=0, mem_mem_wdata=0, mem_mem_addr=0;
logic [4:0]  mem_dst_reg_addr=5'h0;

// WB stage
logic wb_memory2reg=1'b0, wb_regwrite=1'b0;
logic [31:0] wb_alu_res=0, wb_reg_wdata, wb_memout;
logic [4:0]  wb_dst_reg_addr=5'h0;

// hazard signal
logic id_read_disable, id_stall, ex_stall, ex_nop, mem_stall, wb_nop;
logic loaduse, mem_data_bus_conflict;


// -------------------------------------------------------------------------------
// hazard - comb logic
// -------------------------------------------------------------------------------
assign id_read_disable = loaduse;
assign id_stall        = mem_data_bus_conflict;
assign ex_stall        = mem_data_bus_conflict;
assign ex_nop          = loaduse;
assign mem_stall       = mem_data_bus_conflict;
assign wb_nop          = mem_data_bus_conflict;

assign loaduse  = 
            (id_src1_reg_en &  ex_memory2reg & (id_src1_reg_addr== ex_dst_reg_addr) ) |
            (id_src2_reg_en &  ex_memory2reg & (id_src2_reg_addr== ex_dst_reg_addr) ) |
            (id_src1_reg_en & mem_memory2reg & (id_src1_reg_addr==mem_dst_reg_addr) ) |
            (id_src2_reg_en & mem_memory2reg & (id_src2_reg_addr==mem_dst_reg_addr) ) ;


// -------------------------------------------------------------------------------
// Instruction Bus Adapter - timing logic
// -------------------------------------------------------------------------------
core_instr_bus_adapter core_instr_bus_adapter_i(
    .clk                  ( clk                           ),
    .rst_n                ( rst_n                         ),
    .i_boot_addr          ( i_boot_addr                   ),
    .i_stall              ( id_read_disable | id_stall    ),
    .i_bus_disable        ( id_read_disable               ),
    .i_ex_jmp             ( ex_branch_jalr                ),
    .i_ex_target          ( ex_branch_jalr_target         ),
    .i_id_jmp             ( id_jal                        ),
    .i_id_target          ( id_pc + id_imm                ),
    .o_pc                 ( id_pc                         ),
    .o_instr              ( id_instr                      ),
    .bus_master           ( instr_master                  )
);

// -------------------------------------------------------------------------------
// ID stage - comb logic
// -------------------------------------------------------------------------------
core_id_stage core_id_stage_inst(
    .i_instr                 ( id_instr                ),
    .o_src1_reg_en           ( id_src1_reg_en          ),
    .o_src2_reg_en           ( id_src2_reg_en          ), 
    .o_jal                   ( id_jal                  ),
    .o_alures2reg            ( id_alures2reg           ),
    .o_memory2reg            ( id_memory2reg           ),
    .o_mem_write             ( id_memwrite             ),
    .o_src1_reg_addr         ( id_src1_reg_addr        ),
    .o_src2_reg_addr         ( id_src2_reg_addr        ),
    .o_dst_reg_addr          ( id_dst_reg_addr         ),
    .o_opcode                ( id_opcode               ),
    .o_funct7                ( id_funct7               ),
    .o_funct3                ( id_funct3               ),
    .o_imm                   ( id_imm                  )
);


// -------------------------------------------------------------------------------
// ID-EX stage seg reg - timing logic
// -------------------------------------------------------------------------------
core_regfile core_regfile_inst(        // regfile is a part of ID-EX seg reg
    .clk                     ( clk                      ),
    .rst_n                   ( rst_n                    ),
    .rd_latch                ( ex_stall                 ),
    .i_re1                   ( id_src1_reg_en           ),
    .i_raddr1                ( id_src1_reg_addr         ),
    .o_rdata1                ( ex_src1_reg_data         ),
    .i_re2                   ( id_src2_reg_en           ),
    .i_raddr2                ( id_src2_reg_addr         ),
    .o_rdata2                ( ex_src2_reg_data         ),
    .i_forward1              ( ex_alures2reg            ),
    .i_faddr1                ( ex_dst_reg_addr          ),
    .i_fdata1                ( ex_alu_res               ),
    .i_forward2              ( mem_alures2reg           ),
    .i_faddr2                ( mem_dst_reg_addr         ),
    .i_fdata2                ( mem_alu_res              ),
    .i_we                    ( wb_regwrite              ),
    .i_waddr                 ( wb_dst_reg_addr          ),
    .i_wdata                 ( wb_reg_wdata             )
);
always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        ex_alures2reg   <= 1'b0;
        ex_memory2reg   <= 1'b0;
        ex_memwrite     <= 1'b0;
        ex_dst_reg_addr <= 5'h0;
        ex_opcode       <= 7'h0;
        ex_funct3       <= 3'h0;
        ex_funct7       <= 7'h0;
        ex_imm          <= 0;
        ex_pc           <= 0;
    end else if(~ex_stall) begin
        ex_alures2reg   <= ex_nop ? 1'b0 : id_alures2reg;
        ex_memory2reg   <= ex_nop ? 1'b0 : id_memory2reg;
        ex_memwrite     <= ex_nop ? 1'b0 : id_memwrite;
        ex_dst_reg_addr <= ex_nop ? 5'h0 : id_dst_reg_addr;
        ex_opcode       <= ex_nop ? 7'h0 : id_opcode;
        ex_funct7       <= ex_nop ? 7'h0 : id_funct7;
        ex_funct3       <= ex_nop ? 3'h0 : id_funct3;
        ex_imm          <= ex_nop ?    0 : id_imm;
        ex_pc           <= ex_nop ?    0 : id_pc;
    end
    
    
// -------------------------------------------------------------------------------
// EX stage - comb logic
// -------------------------------------------------------------------------------
core_alu core_alu_inst(
    .i_opcode              ( ex_opcode             ),
    .i_funct7              ( ex_funct7             ),
    .i_funct3              ( ex_funct3             ),
    .i_num1u               ( ex_src1_reg_data      ),
    .i_num2u               ( ex_src2_reg_data      ),
    .i_pc                  ( ex_pc                 ),
    .i_immu                ( ex_imm                ),
    .o_branch_jalr         ( ex_branch_jalr        ),
    .o_branch_jalr_target  ( ex_branch_jalr_target ),
    .o_res                 ( ex_alu_res            )
);


// -------------------------------------------------------------------------------
// EX-MEM stage - timing logic
// -------------------------------------------------------------------------------
always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        mem_memory2reg  <= 1'b0;
        mem_alures2reg  <= 1'b0;
        mem_alu_res     <= 0;
        mem_dst_reg_addr<= 5'h0;
        mem_memwrite    <= 1'b0;
        mem_mem_addr    <= 0;
        mem_mem_wdata   <= 0;
        mem_funct3      <= 3'b0;
    end else if(~mem_stall) begin
        mem_memory2reg  <= ex_memory2reg;
        mem_alures2reg  <= ex_alures2reg;
        mem_dst_reg_addr<= ex_dst_reg_addr;
        mem_alu_res     <= ex_alu_res;
        mem_memwrite    <= ex_memwrite;
        mem_mem_addr    <= ex_src1_reg_data + ex_imm;
        mem_mem_wdata   <= ex_src2_reg_data;
        mem_funct3      <= ex_funct3;
    end


// -------------------------------------------------------------------------------
// MEM-WB stage - timing logic
// -------------------------------------------------------------------------------
core_bus_wrapper core_bus_wrapper_inst(
    .clk                  ( clk                   ),
    .rst_n                ( rst_n                 ),
    .i_re                 ( mem_memory2reg        ),
    .i_we                 ( mem_memwrite          ),
    .o_conflict           ( mem_data_bus_conflict ),
    .i_funct3             ( mem_funct3            ),
    .i_addr               ( mem_mem_addr          ),
    .i_wdata              ( mem_mem_wdata         ),
    .o_rdata              ( wb_memout             ),
    .bus_master           ( data_master           )
);
always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        wb_regwrite     <= 1'b0;
        wb_memory2reg   <= 1'b0;
        wb_dst_reg_addr <= 5'h0;
        wb_alu_res      <= 0;
    end else begin
        wb_regwrite     <= wb_nop ? 1'b0 : (mem_alures2reg | mem_memory2reg);
        wb_memory2reg   <= wb_nop ? 1'b0 : mem_memory2reg;
        wb_dst_reg_addr <= wb_nop ? 5'h0 : mem_dst_reg_addr;
        wb_alu_res      <= wb_nop ?    0 : mem_alu_res;
    end
    
// -------------------------------------------------------------------------------
// WB stage - comb logic
// -------------------------------------------------------------------------------
assign wb_reg_wdata = wb_memory2reg  ? wb_memout : wb_alu_res;

endmodule
