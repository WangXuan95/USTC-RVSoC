module core_top(
    input  logic clk, rst_n,
    input  logic [31:0] i_boot_addr,
    naive_bus.master  instr_master, data_master
);

// IF stage out
logic [31:0] if_pc;

// ID stage
logic [31:0] id_instr, id_pc;
logic id_rs1_en, id_rs2_en;
logic [4:0]  id_rs1_addr, id_rs2_addr, id_dst_reg_addr;
logic [31:0] id_next_pc;
logic id_jal, id_jalr, id_branch_may;
logic id_nextpc2reg, id_alures2reg, id_memory2reg;
logic id_memwrite;
logic [6:0]  id_opcode, id_funct7;
logic [2:0]  id_funct3;
logic [31:0] id_pc_plus_imm, id_imm;

// EX stage
logic ex_jalr, ex_branch_may, ex_branch;
logic ex_nextpc2reg, ex_alures2reg, ex_memory2reg;
logic ex_memwrite;
logic [31:0] ex_s1, ex_s2;
logic [6:0]  ex_opcode, ex_funct7;
logic [2:0]  ex_funct3;
logic [31:0] ex_imm, ex_alu_res;
logic [4:0]  ex_dst_reg_addr;
logic [31:0] ex_s1_plus_imm, ex_next_pc, ex_pc_plus_imm;

// MEM stage
logic [2:0]  mem_funct3;
logic mem_memory2reg, mem_alures2reg, mem_memwrite;
logic [31:0] mem_alu_res, mem_mem_wdata, mem_s1_plus_imm;
logic [4:0]  mem_dst_reg_addr;

// WB stage
logic wb_memory2reg;
logic [31:0] wb_reg_wdata;
logic [4:0]  wb_dst_reg_addr;

// write regfile conflict signal
logic launch_nop, pc_stall, id_stall, ex_stall, mem_stall, wreg_conflict;
logic id_data_bus_conflict, mem_data_bus_conflict;


// -------------------------------------------------------------------------------
// conflict - comb logic
// -------------------------------------------------------------------------------
assign pc_stall = id_stall | id_data_bus_conflict;
assign id_stall = wreg_conflict;// | mem_data_bus_conflict;
assign ex_stall = mem_data_bus_conflict;
assign mem_stall = mem_data_bus_conflict;
assign launch_nop = ex_branch | ex_jalr | wreg_conflict;

assign wreg_conflict = 
            (id_rs1_en & ex_alures2reg & (id_rs1_addr== ex_dst_reg_addr) ) |
            (id_rs2_en & ex_alures2reg & (id_rs2_addr== ex_dst_reg_addr) ) |
            (id_rs1_en & ex_memory2reg & (id_rs1_addr== ex_dst_reg_addr) ) |
            (id_rs2_en & ex_memory2reg & (id_rs2_addr== ex_dst_reg_addr) ) |
            (id_rs1_en &mem_memory2reg & (id_rs1_addr==mem_dst_reg_addr) ) |
            (id_rs2_en &mem_memory2reg & (id_rs2_addr==mem_dst_reg_addr) ) ;
       

    
// -------------------------------------------------------------------------------
// IF stage - comb logic
// -------------------------------------------------------------------------------
always_comb
    if(ex_branch)
        if_pc <= ex_pc_plus_imm;
    else if(ex_jalr)
        if_pc <= ex_s1_plus_imm;
    else if(id_jal)
        if_pc <= id_pc_plus_imm;
    else if(pc_stall)
        if_pc <= id_pc;
    else
        if_pc <= id_next_pc;


// -------------------------------------------------------------------------------
// IF-ID stage - timing logic
// -------------------------------------------------------------------------------
core_bus_wrapper inst_bus_wrap_inst(
    .clk                  ( clk                  ),
    .rst_n                ( rst_n                ),
    .i_re                 ( ~id_stall            ),
    .i_we                 ( 1'b0                 ),
    .o_conflict_latch     ( id_data_bus_conflict ),
    .i_funct3             ( 3'b010               ),
    .i_addr               ( if_pc                ),
    .i_wdata              ( 0                    ),
    .o_rdata              ( id_instr             ),
    .bus_master           ( instr_master         )
);
always @ (posedge clk)
    if(~rst_n)
        id_pc <= {i_boot_addr[31:2],2'b00} - 4;
    else
        id_pc <= if_pc;


// -------------------------------------------------------------------------------
// ID stage - comb logic
// -------------------------------------------------------------------------------
core_id_stage core_id_stage_inst(
    .i_instr                 ( id_instr       ),
    .i_pc                    ( id_pc          ),
    .o_rs1_addr              ( id_rs1_addr    ),
    .o_rs2_addr              ( id_rs2_addr    ),
    .o_rs1_en                ( id_rs1_en      ),
    .o_rs2_en                ( id_rs2_en      ), 
    .o_jal                   ( id_jal         ),
    .o_jalr                  ( id_jalr        ),
    .o_branch_may            ( id_branch_may  ),
    .o_nextpc2reg            ( id_nextpc2reg  ),
    .o_alures2reg            ( id_alures2reg  ),
    .o_memory2reg            ( id_memory2reg  ),
    .o_mem_write             ( id_memwrite    ),
    .o_pc_plus_imm           ( id_pc_plus_imm ),
    .o_imm                   ( id_imm         ),
    .o_dst_reg_addr          ( id_dst_reg_addr),
    .o_opcode                ( id_opcode      ),
    .o_funct7                ( id_funct7      ),
    .o_funct3                ( id_funct3      ),
    .o_next_pc               ( id_next_pc     )
);


// -------------------------------------------------------------------------------
// ID-EX stage - timing logic
// -------------------------------------------------------------------------------
core_regfile core_regfile_inst(
    .clk                     ( clk            ),
    .rst_n                   ( rst_n          ),
    .rd_latch                ( ex_stall       ),
    .i_re1                   ( id_rs1_en      ),
    .i_raddr1                ( id_rs1_addr    ),
    .o_rdata1                ( ex_s1          ),
    .i_re2                   ( id_rs2_en      ),
    .i_raddr2                ( id_rs2_addr    ),
    .o_rdata2                ( ex_s2          ),
    .i_we1                   ( ex_nextpc2reg  ),
    .i_waddr1                ( ex_dst_reg_addr),
    .i_wdata1                ( ex_next_pc     ),
    .i_we2                   ( mem_alures2reg ),
    .i_waddr2                (mem_dst_reg_addr),
    .i_wdata2                ( mem_alu_res    ),
    .i_we3                   ( wb_memory2reg  ),
    .i_waddr3                ( wb_dst_reg_addr),
    .i_wdata3                ( wb_reg_wdata   )
);
always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        ex_jalr         <= 1'b0;
        ex_branch_may   <= 1'b0;
        ex_nextpc2reg   <= 1'b0;
        ex_alures2reg   <= 1'b0;
        ex_memory2reg   <= 1'b0;
        ex_memwrite     <= 1'b0;
        ex_dst_reg_addr <= 5'h0;
        ex_imm          <= 0;
        ex_opcode       <= 7'h0;
        ex_funct3       <= 3'h0;
        ex_funct7       <= 7'h0;
        ex_next_pc      <= 0;
    end else if(~ex_stall) begin
        ex_jalr         <= launch_nop ? 1'b0 : id_jalr;
        ex_branch_may   <= launch_nop ? 1'b0 : id_branch_may;
        ex_pc_plus_imm  <= id_pc_plus_imm;
        ex_nextpc2reg   <= launch_nop ? 1'b0 : id_nextpc2reg;
        ex_alures2reg   <= launch_nop ? 1'b0 : id_alures2reg;
        ex_memory2reg   <= launch_nop ? 1'b0 : id_memory2reg;
        ex_memwrite     <= launch_nop ? 1'b0 : id_memwrite;
        ex_dst_reg_addr <= id_dst_reg_addr;
        ex_imm          <= id_imm;
        ex_opcode       <= id_opcode;
        ex_funct3       <= id_funct3;
        ex_funct7       <= id_funct7;
        ex_next_pc      <= id_next_pc;
    end
    
    
// -------------------------------------------------------------------------------
// EX stage - comb logic
// -------------------------------------------------------------------------------
core_alu core_alu_inst(
    .i_opcode     ( ex_opcode   ),
    .i_funct7     ( ex_funct7   ),
    .i_funct3     ( ex_funct3   ),
    .i_num1u      ( ex_s1       ),
    .i_num2u      ( ex_s2       ),
    .i_immu       ( ex_imm      ),
    .o_res        ( ex_alu_res  )
);
core_ex_branch_judge core_ex_branch_judge_inst(
    .i_branch     ( ex_branch_may   ),
    .i_num1u      ( ex_s1           ),
    .i_num2u      ( ex_s2           ),
    .i_funct3     ( ex_funct3       ),
    .o_branch     ( ex_branch       )
);
assign ex_s1_plus_imm = ex_s1 + ex_imm;

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
        mem_mem_wdata   <= 0;
        mem_s1_plus_imm <= 0;
        mem_funct3      <= 3'b0;
    end else if(~mem_stall) begin
        mem_memory2reg  <= ex_memory2reg;
        mem_alures2reg  <= ex_alures2reg;
        mem_alu_res     <= ex_alu_res;
        mem_dst_reg_addr<= ex_dst_reg_addr;
        mem_memwrite    <= ex_memwrite;
        mem_mem_wdata   <= ex_s2;
        mem_s1_plus_imm <= ex_s1_plus_imm;
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
    .i_addr               ( mem_s1_plus_imm       ),
    .i_wdata              ( mem_mem_wdata         ),
    .o_rdata              ( wb_reg_wdata          ),
    .bus_master           ( data_master           )
);
always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        wb_memory2reg   <= 1'b0;
        wb_dst_reg_addr <= 5'h0;
    end else begin
        wb_memory2reg   <= mem_memory2reg;
        wb_dst_reg_addr <= mem_dst_reg_addr;
    end

endmodule
