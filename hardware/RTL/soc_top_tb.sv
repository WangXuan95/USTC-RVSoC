module soc_top_tb();

logic clk;
initial clk = 1'b1;
always #1 clk = ~clk;

wire vga_vsync, vga_hsync, isp_uart_tx;
wire [15:0]  vga_pixel;

soc_top soc_inst(
    .clk              ( clk         ),
    .isp_uart_rx      ( 1'b1        ),
    .isp_uart_tx      ( isp_uart_tx ),
    .vga_hsync        ( vga_hsync   ),
    .vga_vsync        ( vga_vsync   ),
    .vga_pixel        ( vga_pixel   )
);

endmodule
