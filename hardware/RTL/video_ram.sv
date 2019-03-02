module video_ram #(
    parameter VGA_CLK_DIV = 1
)(
    input  logic clk, rst_n,
	output logic o_hsync, o_vsync,
	output logic o_red, o_green, o_blue,
    naive_bus.slave  bus
);

logic vga_req;
logic [ 9:0] vga_addr_h;
logic [ 1:0] vga_addr_l, vga_addr_l_latch = 2'b00;
logic [ 7:0] vga_ascii;
logic [ 9:0] cell_wr_addr, cell_rd_addr;
logic [ 7:0] vga_rdata [4];

assign bus.rd_gnt = (~vga_req) & bus.rd_req;
assign bus.wr_gnt = bus.wr_req;
assign bus.rd_data = {vga_rdata[3],vga_rdata[2],vga_rdata[1],vga_rdata[0]};
assign cell_wr_addr = bus.wr_addr[11:2];
assign cell_rd_addr = vga_req ? vga_addr_h : bus.rd_addr[11:2];

always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        vga_addr_l_latch <= 2'b00;
    else
        vga_addr_l_latch <= vga_addr_l;
    
ram ram_block_inst_0(
    .clk       ( clk                       ),
    .i_we      ( bus.wr_req & bus.wr_be[0] ),
    .i_waddr   ( cell_wr_addr              ),
    .i_wdata   ( bus.wr_data[ 7: 0]        ),
    .i_raddr   ( cell_rd_addr              ),
    .o_rdata   ( vga_rdata[0]              )
);
ram ram_block_inst_1(
    .clk       ( clk                       ),
    .i_we      ( bus.wr_req & bus.wr_be[1] ),
    .i_waddr   ( cell_wr_addr              ),
    .i_wdata   ( bus.wr_data[15: 8]        ),
    .i_raddr   ( cell_rd_addr              ),
    .o_rdata   ( vga_rdata[1]              )
);
ram ram_block_inst_2(
    .clk       ( clk                       ),
    .i_we      ( bus.wr_req & bus.wr_be[2] ),
    .i_waddr   ( cell_wr_addr              ),
    .i_wdata   ( bus.wr_data[23:16]        ),
    .i_raddr   ( cell_rd_addr              ),
    .o_rdata   ( vga_rdata[2]              )
);
ram ram_block_inst_3(
    .clk       ( clk                       ),
    .i_we      ( bus.wr_req & bus.wr_be[3] ),
    .i_waddr   ( cell_wr_addr              ),
    .i_wdata   ( bus.wr_data[31:24]        ),
    .i_raddr   ( cell_rd_addr              ),
    .o_rdata   ( vga_rdata[3]              )
);

always_comb
    case(vga_addr_l_latch)
    2'b00 : vga_ascii <= vga_rdata[0];
    2'b01 : vga_ascii <= vga_rdata[1];
    2'b10 : vga_ascii <= vga_rdata[2];
    2'b11 : vga_ascii <= vga_rdata[3];
    endcase

vga_char_86x32  #(
    .VGA_CLK_DIV   ( VGA_CLK_DIV  )
) vga_char_86x32_inst(
    .clk       ( clk                     ),
    .rst_n     ( rst_n                   ),
    .hsync     ( o_hsync                 ),
    .vsync     ( o_vsync                 ),
    .red       ( o_red                   ),
    .green     ( o_green                 ),
    .blue      ( o_blue                  ),
    .req       ( vga_req                 ),
    .addr      ( {vga_addr_h,vga_addr_l} ),
    .ascii     ( vga_ascii               )
);

endmodule
