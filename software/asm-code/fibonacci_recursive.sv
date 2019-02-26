module instr_rom(
    input  logic clk, rst_n,
    naive_bus.slave  bus
);
localparam  INSTR_CNT = 30'd36;
wire [0:INSTR_CNT-1] [31:0] instr_rom_cell = {
    32'h12300013,   // 0x00000000
    32'h45600013,   // 0x00000004
    32'h00010137,   // 0x00000008
    32'h40016113,   // 0x0000000c
    32'h00804293,   // 0x00000010
    32'h008000ef,   // 0x00000014
    32'h05c0006f,   // 0x00000018
    32'h00306513,   // 0x0000001c
    32'h00a2f663,   // 0x00000020
    32'h0002e313,   // 0x00000024
    32'h00008067,   // 0x00000028
    32'hffc10113,   // 0x0000002c
    32'h00112023,   // 0x00000030
    32'hfff28293,   // 0x00000034
    32'hffc10113,   // 0x00000038
    32'h00512023,   // 0x0000003c
    32'hfddff0ef,   // 0x00000040
    32'h00012283,   // 0x00000044
    32'h00410113,   // 0x00000048
    32'hfff28293,   // 0x0000004c
    32'hffc10113,   // 0x00000050
    32'h00612023,   // 0x00000054
    32'hfc5ff0ef,   // 0x00000058
    32'h00012383,   // 0x0000005c
    32'h00410113,   // 0x00000060
    32'h00730333,   // 0x00000064
    32'h00012083,   // 0x00000068
    32'h00410113,   // 0x0000006c
    32'h00008067,   // 0x00000070
    32'h000062b3,   // 0x00000074
    32'h000302b7,   // 0x00000078
    32'h00628023,   // 0x0000007c
    32'h00c003b7,   // 0x00000080
    32'hfff38393,   // 0x00000084
    32'hfe039ee3,   // 0x00000088
    32'hfe9ff06f    // 0x0000008c
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

