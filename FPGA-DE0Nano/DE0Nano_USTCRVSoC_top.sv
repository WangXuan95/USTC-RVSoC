module DE0Nano_USTCRVSoC_top(
    //////////// CLOCK            //////////
    input          CLOCK_50,
    //////////// LED, KEY, Switch //////////
    output [ 7:0]  LED,
    //////////// GPIO Header 1    //////////
    output [33:0]  GPIO_0,
    input  [ 0:0]  GPIO_1_IN,
    output [ 0:0]  GPIO_1
);

logic vga_red, vga_green, vga_blue;
assign GPIO_0[31:16] = {{5{vga_blue}},{6{vga_green}},{5{vga_red}}};

soc_top #(
    .UART_RX_CLK_DIV  ( 108           ),   // 50MHz/4/115200 = 108
    .UART_TX_CLK_DIV  ( 434           ),   // 50MHz/1/115200 = 434
    .VGA_CLK_DIV      ( 1             )
) soc_i (
    .clk              ( CLOCK_50      ),
    .isp_uart_rx      ( GPIO_1_IN[0]  ),
    .isp_uart_tx      ( GPIO_1[0]     ),
    .vga_hsync        ( GPIO_0[33]    ),
    .vga_vsync        ( GPIO_0[32]    ),
    .vga_red          ( vga_red       ),
    .vga_green        ( vga_green     ),
    .vga_blue         ( vga_blue      )
);

// 在开发板的LED上显示ISP-UART和USER-UART的发送灯和接收灯
assign LED[7:6] = ~{GPIO_1_IN[0], GPIO_1[0]};

// VGA GND
assign GPIO_0[15:0] = 16'b0;

// 流水灯，指示SoC在运行
reg [21:0] cnt = 22'h0;
reg [ 5:0] flow = 6'h0;
always @ (posedge CLOCK_50) begin
    cnt <= cnt + 22'h1;
    if(cnt==22'h0)
        flow <= {flow[4:0], ~flow[5]};
end
    
assign LED[5:0] = flow;

endmodule
