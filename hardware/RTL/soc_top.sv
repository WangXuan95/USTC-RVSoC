module soc_top  #(
    parameter  UART_RX_CLK_DIV = 108,   // 50MHz/4/115200Hz=108
    parameter  UART_TX_CLK_DIV = 434,   // 50MHz/1/115200Hz=434
    parameter  VGA_CLK_DIV     = 1
)(
    // clock, typically 50MHz, UART_RX_CLK_DIV and UART_TX_CLK_DIV and VGA_CLK_DIV must be modify when clk is not 50MHz
    input  logic clk,
    // debug uart and user uart shared signal
    input  logic isp_uart_rx,
    output logic isp_uart_tx,
    // VGA signal
    output logic vga_hsync, vga_vsync,
    output logic vga_red, vga_green, vga_blue
);
logic rst_n;
logic [31:0] boot_addr;

naive_bus  bus_masters[3]();
naive_bus  bus_slaves[5]();

// shared debug uart and user uart module
isp_uart  #(
   .UART_RX_CLK_DIV    ( UART_RX_CLK_DIV),
   .UART_TX_CLK_DIV    ( UART_TX_CLK_DIV)
) isp_uart_inst(
    .clk               ( clk            ),
    .i_uart_rx         ( isp_uart_rx    ),
    .o_uart_tx         ( isp_uart_tx    ),
    .o_rst_n           ( rst_n          ),
    .o_boot_addr       ( boot_addr      ),
    .bus               ( bus_masters[0] ),
    .user_uart_bus     ( bus_slaves[4]  )
);

// RV32I Core
core_top core_top_inst(
    .clk               ( clk            ),
    .rst_n             ( rst_n          ),
    .i_boot_addr       ( boot_addr      ),
    .instr_master      ( bus_masters[2] ),
    .data_master       ( bus_masters[1] )
);

// 指令ROM
instr_rom instr_rom_inst(
    .clk               ( clk            ),
    .rst_n             ( rst_n          ),
    .bus               ( bus_slaves[0]  )
);

// 指令RAM
ram_bus_wrapper instr_ram_inst(
    .clk               ( clk            ),
    .rst_n             ( rst_n          ),
    .bus               ( bus_slaves[1]  )
);

// 数据RAM
ram_bus_wrapper data_ram_inst(
    .clk               ( clk            ),
    .rst_n             ( rst_n          ),
    .bus               ( bus_slaves[2]  )
);


// 显存 
video_ram  #(
    .VGA_CLK_DIV       ( VGA_CLK_DIV    )
)video_ram_inst(
    .clk               ( clk            ),
    .rst_n             ( rst_n          ),
    .bus               ( bus_slaves[3]  ),
    .o_vsync           ( vga_vsync      ),
    .o_hsync           ( vga_hsync      ),
    .o_red             ( vga_red        ),
    .o_green           ( vga_green      ),
    .o_blue            ( vga_blue       )
);


// 3��?5从�?�线仲裁��?
//
// 主（越靠前优先级越高）：
//   0. UART Debugger?
//   1. Core Data Master
//   2. Core Instruction  Master
//
// 从：
//   1. 指令ROM��? 地址空间 00000000~00000fff
//   2. 指令RAM��? 地址空间 00008000~00008fff
//   3. 数据RAM��? 地址空间 00010000~00010fff
//   4. 显存RAM��? 地址空间 00020000~00020fff
//   5. 用户UART，   地址空间 00030000~00030003
naive_bus_router #(
    .N_MASTER          ( 3 ),
    .N_SLAVE           ( 5 ),
    .SLAVES_MASK       ( { 32'h0000_0003 , 32'h0000_0fff , 32'h0000_0fff , 32'h0000_0fff  , 32'h0000_0fff } ),
    .SLAVES_BASE       ( { 32'h0003_0000 , 32'h0002_0000 , 32'h0001_0000 , 32'h0000_8000  , 32'h0000_0000 } )
) soc_bus_router_inst (
    .clk               ( clk          ),
    .rst_n             ( rst_n        ),
    .masters           ( bus_masters  ),
    .slaves            ( bus_slaves   )
);

endmodule

