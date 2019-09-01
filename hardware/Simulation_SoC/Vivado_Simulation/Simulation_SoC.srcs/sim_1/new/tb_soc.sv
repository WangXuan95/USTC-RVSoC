`timescale 1ns/1ns

module tb_soc();

logic clk = 1'b1;
always #5 clk = ~clk;  // 100MHz clock

wire uart_tx, vga_hsync, vga_vsync;
wire [ 2:0] vga_pixel;

soc_top soc_inst(
    .clk              ( clk          ),
    .isp_uart_rx      ( 1'b1         ),
    .isp_uart_tx      ( uart_tx      ),
    .vga_hsync        ( vga_hsync    ),
    .vga_vsync        ( vga_vsync    ),
    .vga_red          ( vga_pixel[2] ),
    .vga_green        ( vga_pixel[1] ),
    .vga_blue         ( vga_pixel[0] )
);

initial #800000 $stop;

endmodule
