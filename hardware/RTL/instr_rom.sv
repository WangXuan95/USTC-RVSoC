module instr_rom(
    input  logic clk, rst_n,
    naive_bus.slave  bus
);
localparam  INSTR_CNT = 30'd18;
wire [0:INSTR_CNT-1] [31:0] instr_rom_cell = {
    32'h000062b3,   // 0x00000000
    32'h000302b7,   // 0x00000004
    32'h06806313,   // 0x00000008
    32'h00628023,   // 0x0000000c
    32'h06506313,   // 0x00000010
    32'h00628023,   // 0x00000014
    32'h06c06313,   // 0x00000018
    32'h00628023,   // 0x0000001c
    32'h06c06313,   // 0x00000020
    32'h00628023,   // 0x00000024
    32'h06f06313,   // 0x00000028
    32'h00628023,   // 0x0000002c
    32'h00a06313,   // 0x00000030
    32'h00628023,   // 0x00000034
    32'h00c003b7,   // 0x00000038
    32'hfff38393,   // 0x0000003c
    32'hfe039ee3,   // 0x00000040
    32'hfc5ff06f    // 0x00000044
};

logic [29:0] cell_rd_addr;

assign bus.rd_gnt = bus.rd_req;
assign bus.wr_gnt = bus.wr_req;
assign cell_rd_addr = bus.rd_addr[31:2];
always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        bus.rd_data <= 0;
    else begin
        if(bus.rd_req)
            bus.rd_data <= (cell_rd_addr>=INSTR_CNT) ? 0 : instr_rom_cell[cell_rd_addr];
        else
            bus.rd_data <= 0;
        end

endmodule

