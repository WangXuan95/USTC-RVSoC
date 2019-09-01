
module core_instr_bus_adapter(
    input  logic clk, rst_n,
    input  logic [31:0] i_boot_addr,
    input  logic i_stall, i_bus_disable,
    input  logic i_ex_jmp, i_id_jmp,
    input  logic [31:0] i_ex_target, i_id_target, 
    output logic [31:0] o_pc, o_instr,
    
    naive_bus.master  bus_master
);
logic [31:0] npc, instr_hold=0;
logic bus_busy=1'b0, stall_n = 1'b0;

initial o_pc=0;

assign bus_master.wr_req  = 1'b0;     // core never write via instruction bus
assign bus_master.wr_be   = 4'h0;
assign bus_master.wr_addr = 0;
assign bus_master.wr_data = 0;

assign bus_master.rd_req  = ~i_bus_disable;
assign bus_master.rd_be   = {4{~i_bus_disable}};
assign bus_master.rd_addr = npc;

always_comb
    if(i_ex_jmp)
        npc <= i_ex_target;
    else if(i_id_jmp)
        npc <= i_id_target;
    else if( i_bus_disable | bus_busy )
        npc <= o_pc;
    else
        npc <= o_pc + 4;

always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        stall_n  <= 1'b0;
        bus_busy <= 1'b0;
        instr_hold <= 0;
    end else begin
        stall_n  <= ~i_stall;
        bus_busy <= (bus_master.rd_req & ~bus_master.rd_gnt);
        instr_hold <= o_instr;
    end

always_comb
    if(~stall_n)
        o_instr <= instr_hold;
    else if(i_ex_jmp | bus_busy)
        o_instr <= 0;
    else
        o_instr <= bus_master.rd_data;

always @ (posedge clk)
    if(~rst_n)
        o_pc <= {i_boot_addr[31:2],2'b00} - 4;
    else
        o_pc <= npc;

endmodule
