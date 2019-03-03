
module Nexys4_USTCRVSoC_top(
    input  logic CLK100MHZ,
    input  logic [15:0] SW,
    output logic [15:0] LED,
    output logic UART_RXD_OUT,
    input  logic UART_TXD_IN,
    output logic VGA_HS, VGA_VS,
    output logic [3:0] VGA_R, VGA_G, VGA_B
);

logic vga_red, vga_green, vga_blue;
assign {VGA_R, VGA_G, VGA_B} = {{4{vga_red}}, {4{vga_green}}, {4{vga_blue}}};

soc_top  #(
    .UART_RX_CLK_DIV  ( 217           ),
    .UART_TX_CLK_DIV  ( 868           ),
    .VGA_CLK_DIV      ( 2             )
)soc_inst (
    .clk              ( CLK100MHZ     ),
    .isp_uart_rx      ( UART_TXD_IN   ),
    .isp_uart_tx      ( UART_RXD_OUT  ),
    .vga_hsync        ( VGA_HS        ),
    .vga_vsync        ( VGA_VS        ),
    .vga_red          ( vga_red       ),
    .vga_green        ( vga_green     ),
    .vga_blue         ( vga_blue      )
);

// 在开发板的LED上显示ISP-UART的发送灯和接收灯
assign LED[15:14] = ~{UART_TXD_IN, UART_RXD_OUT};

// 流水灯，指示SoC在运行
reg [21:0] cnt = 22'h0;
reg [ 7:0] flow = 7'h0;
always @ (posedge CLK100MHZ) begin
        cnt <= cnt + 22'h1;
        if(cnt==22'h0)
            flow <= {flow[6:0], ~flow[7]};
    end
    
assign LED[7:0] = flow;

endmodule
