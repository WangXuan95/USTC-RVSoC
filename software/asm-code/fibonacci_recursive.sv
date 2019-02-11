module instr_rom(
    input  logic clk, rst_n,
    naive_bus.slave  bus
);
localparam  INSTR_CNT = 30'd36;
wire [0:INSTR_CNT-1] [31:0] instr_rom_cell = {
    32'h12300013,   // 0x00008000
    32'h45600013,   // 0x00008004
    32'h00010137,   // 0x00008008
    32'h40016113,   // 0x0000800c
    32'h00704293,   // 0x00008010
    32'h008000ef,   // 0x00008014
    32'h05c0006f,   // 0x00008018
    32'h00306513,   // 0x0000801c
    32'h00a2f663,   // 0x00008020
    32'h0002e313,   // 0x00008024
    32'h00008067,   // 0x00008028
    32'hffc10113,   // 0x0000802c
    32'h00112023,   // 0x00008030
    32'hfff28293,   // 0x00008034
    32'hffc10113,   // 0x00008038
    32'h00512023,   // 0x0000803c
    32'hfddff0ef,   // 0x00008040
    32'h00012283,   // 0x00008044
    32'h00410113,   // 0x00008048
    32'hfff28293,   // 0x0000804c
    32'hffc10113,   // 0x00008050
    32'h00612023,   // 0x00008054
    32'hfc5ff0ef,   // 0x00008058
    32'h00012383,   // 0x0000805c
    32'h00410113,   // 0x00008060
    32'h00730333,   // 0x00008064
    32'h00012083,   // 0x00008068
    32'h00410113,   // 0x0000806c
    32'h00008067,   // 0x00008070
    32'h000062b3,   // 0x00008074
    32'h000302b7,   // 0x00008078
    32'h00628023,   // 0x0000807c
    32'h00c003b7,   // 0x00008080
    32'hfff38393,   // 0x00008084
    32'hfe039ee3,   // 0x00008088
    32'hfe9ff06f,   // 0x0000808c
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

