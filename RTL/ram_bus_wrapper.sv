
module ram_bus_wrapper(   // 4kB, valid address: 0x0000_0000 ~ 0x0000_0fff
    input  logic clk,
    naive_bus.slave  bus
);

logic [9:0] cell_rd_addr, cell_wr_addr;

assign cell_rd_addr = bus.rd_addr[11:2];
assign cell_wr_addr = bus.wr_addr[11:2];

assign bus.rd_gnt = bus.rd_req;
assign bus.wr_gnt = bus.wr_req;
    
ram ram_i0(
    .clk       ( clk                       ),
    .i_we      ( bus.wr_req & bus.wr_be[0] ),
    .i_waddr   ( cell_wr_addr              ),
    .i_raddr   ( cell_rd_addr              ),
    .i_wdata   ( bus.wr_data[ 7: 0]        ),
    .o_rdata   ( bus.rd_data[ 7: 0]        )
);
ram ram_i1(
    .clk       ( clk                       ),
    .i_we      ( bus.wr_req & bus.wr_be[1] ),
    .i_waddr   ( cell_wr_addr              ),
    .i_raddr   ( cell_rd_addr              ),
    .i_wdata   ( bus.wr_data[15: 8]        ),
    .o_rdata   ( bus.rd_data[15: 8]        )
);
ram ram_i2(
    .clk       ( clk                       ),
    .i_we      ( bus.wr_req & bus.wr_be[2] ),
    .i_waddr   ( cell_wr_addr              ),
    .i_raddr   ( cell_rd_addr              ),
    .i_wdata   ( bus.wr_data[23:16]        ),
    .o_rdata   ( bus.rd_data[23:16]        )
);
ram ram_i3(
    .clk       ( clk                       ),
    .i_we      ( bus.wr_req & bus.wr_be[3] ),
    .i_waddr   ( cell_wr_addr              ),
    .i_raddr   ( cell_rd_addr              ),
    .i_wdata   ( bus.wr_data[31:24]        ),
    .o_rdata   ( bus.rd_data[31:24]        )
);

endmodule
