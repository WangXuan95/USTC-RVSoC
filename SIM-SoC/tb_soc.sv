
`timescale 1ps/1ps

module tb_soc();

logic clk = 1'b1;
always #10000 clk = ~clk;   // 50MHz clock

wire        uart_tx;
wire        vga_hsync, vga_vsync, vga_red, vga_green, vga_blue;

soc_top #(
    .UART_RX_CLK_DIV  ( 108           ),   // 50MHz/4/115200 = 108
    .UART_TX_CLK_DIV  ( 434           ),   // 50MHz/1/115200 = 434
    .VGA_CLK_DIV      ( 1             )
) soc_i (
    .clk              ( clk           ),
    .isp_uart_rx      ( 1'b1          ),
    .isp_uart_tx      ( uart_tx       ),
    .vga_hsync        ( vga_hsync     ),
    .vga_vsync        ( vga_vsync     ),
    .vga_red          ( vga_red       ),
    .vga_green        ( vga_green     ),
    .vga_blue         ( vga_blue      )
);

endmodule
