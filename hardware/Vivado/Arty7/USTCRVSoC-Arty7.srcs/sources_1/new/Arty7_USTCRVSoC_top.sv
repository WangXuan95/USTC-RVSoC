
module Arty7_USTCRVSoC_top(
    input  logic CLK100MHZ,
    output logic [3:0] LED,
    output logic [1:0] LEDB,
    output logic UART_TX,
    input  logic UART_RX
);

logic [26:0] cnt  = 22'h0;

soc_top  #(
    .UART_RX_CLK_DIV  ( 217       ),
    .UART_TX_CLK_DIV  ( 868       ),
    .VGA_CLK_DIV      ( 2         )
)soc_inst (
    .clk              ( CLK100MHZ ),
    .isp_uart_rx      ( UART_RX   ),
    .isp_uart_tx      ( UART_TX   ),
    .vga_hsync        (           ), // there is no VGA port on Arty-7
    .vga_vsync        (           ), // so leave these pins float
    .vga_red          (           ),
    .vga_green        (           ),
    .vga_blue         (           )
);

// show UART on blue LED (RGB LED on Arty-7)
assign LEDB = ~{UART_RX, UART_TX};

// blink leds to show that the clock is working
always @ (posedge CLK100MHZ) begin
    case(cnt[26:24])
    3'd0 : LED <= 4'b0001;
    3'd1 : LED <= 4'b0010;
    3'd2 : LED <= 4'b0100;
    3'd3 : LED <= 4'b1000;
    3'd4 : LED <= 4'b1000;
    3'd5 : LED <= 4'b0100;
    3'd6 : LED <= 4'b0010;
    3'd7 : LED <= 4'b0001;
    endcase
    cnt++;
end

endmodule
