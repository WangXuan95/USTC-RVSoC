module DE0_Nano_USTCRVSoC_top(
    //////////// CLOCK //////////
    input  CLOCK_50,
    //////////// LED, KEY, Switch //////////
    output [7:0] LED,
    input  [1:0] KEY,
    input  [3:0] SW,
    //////////// GPIO Header 1 //////////
    input  [1:0]   GPIO_0_IN,
    inout  [33:0]  GPIO_0,
    input  [1:0]   GPIO_1_IN,
    inout  [33:0]  GPIO_1,
    //////////// ADC //////////
    output ADC_CS_N, ADC_SADDR, ADC_SCLK,
    input  ADC_SDAT,
    //////////// Accelerometer and EEPROM //////////
    output G_SENSOR_CS_N,
    input  G_SENSOR_INT,
    output I2C_SCLK,
    inout  I2C_SDAT,
    //////////// SDRAM //////////
    output [12:0] DRAM_ADDR,
    output [1:0]  DRAM_BA,
    output DRAM_CAS_N, DRAM_CKE, DRAM_CLK, DRAM_CS_N, DRAM_RAS_N, DRAM_WE_N,
    inout  [15:0] DRAM_DQ,
    output [1:0]  DRAM_DQM
);

soc_top soc_inst(
    .clk              ( CLOCK_50      ),
    .isp_uart_rx      ( GPIO_1_IN[0]  ),
    .isp_uart_tx      ( GPIO_1[0]     ),
    .user_uart_rx     ( GPIO_1_IN[1]  ),
    .user_uart_tx     ( GPIO_1[1]     ),
    .vga_hsync        ( GPIO_0[33]    ),
    .vga_vsync        ( GPIO_0[32]    ),
    .vga_pixel        ( GPIO_0[31:16] )
);

// 在开发板的LED上显示ISP-UART和USER-UART的发送灯和接收灯
assign LED[7:4] = ~{GPIO_1_IN[0],GPIO_1[0],GPIO_1_IN[1],GPIO_1[1]};

// VGA GND
assign GPIO_0[12] = 1'b0;

endmodule
