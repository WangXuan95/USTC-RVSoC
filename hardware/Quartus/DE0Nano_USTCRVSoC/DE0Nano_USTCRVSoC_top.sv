module DE0Nano_USTCRVSoC_top(
    //////////// CLOCK //////////
    input  CLOCK_50,
    //////////// LED, KEY, Switch //////////
    output [7:0] LED,
    //////////// GPIO Header 1 //////////
    input  [1:0]   GPIO_0_IN,
    inout  [33:0]  GPIO_0,
    input  [1:0]   GPIO_1_IN,
    inout  [33:0]  GPIO_1
);

logic vga_red, vga_green, vga_blue;
assign GPIO_0[31:16] = {{5{vga_blue}},{6{vga_green}},{5{vga_red}}};

soc_top soc_inst(
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
assign LED[7:6] = ~{GPIO_1_IN[0],GPIO_1[0]};

// VGA GND
assign GPIO_0[12] = 1'b0;

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
