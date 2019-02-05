module top(
    input  CLK,
    input  [1:0] KEY,
    output [7:0] LED,
    output UART_TX,
    input  UART_RX,
    output [2:0] RGBA, RGBB,
    output [7:0] DTA, DTB,
    output ADXL_SCL,
    inout  ADXL_SDA,
    output EEPROM_SCL,
    inout  EEPROM_SDA,
    inout  [ 9:0] IOA,
    inout  [23:0] IOB
);

soc_top soc_inst(
    .clk              ( CLK         ),
    .isp_uart_rx      ( UART_RX     ),
    .isp_uart_tx      ( UART_TX     ),
    .user_uart_rx     ( IOA[0]      ),
    .user_uart_tx     ( IOA[1]      ),
    .vga_hsync        ( IOB[1]      ),
    .vga_vsync        ( IOB[0]      ),
    .vga_pixel        ( IOB[17:2]   )
);

assign IOB[23:22] = 2'b00;

endmodule
