
module core_id_segreg(
    input  logic clk, rst_n,
    input  logic [31:0] i_boot_addr,
    input  logic i_en, i_re, i_ex_jmp, i_id_jmp,
    input  logic [31:0] i_ex_jmp_target, i_id_jmp_target, 
    output logic [31:0] o_pc, o_instr,
    
    naive_bus.master  bus_master
);
logic [31:0] target_pc, instr_latch=0;
logic conflict, conflict_latch=1'b0, instr_hold_n = 1'b0;

initial begin o_pc=0; end 

assign bus_master.wr_req  = 1'b0;     // core never write instruction ram
assign bus_master.wr_be   = 4'h0;
assign bus_master.wr_addr = 0;
assign bus_master.wr_data = 0;
assign bus_master.rd_req  = i_re;
assign bus_master.rd_be   = {4{i_re}};
assign bus_master.rd_addr = i_re ? target_pc : 0;
assign conflict = (bus_master.rd_req & ~bus_master.rd_gnt);

always_comb
    if(i_ex_jmp)
        target_pc <= i_ex_jmp_target;
    else if(i_id_jmp)
        target_pc <= i_id_jmp_target;
    else if( ~(i_re) | conflict_latch)
        target_pc <= o_pc;
    else
        target_pc <= o_pc + 4;

always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        instr_hold_n  <= 1'b0;
        conflict_latch <= 1'b0;
        instr_latch <= 0;
    end else begin
        instr_hold_n  <= i_re & i_en;
        conflict_latch <= conflict;
        instr_latch <= o_instr;
    end

always_comb
    if(~instr_hold_n)
        o_instr <= instr_latch;
    else if(i_ex_jmp | conflict_latch)
        o_instr <= 0;
    else
        o_instr <= bus_master.rd_data;

always @ (posedge clk)
    if(~rst_n)
        o_pc <= {i_boot_addr[31:2],2'b00} - 4;
    else
        o_pc <= target_pc;

endmodule
