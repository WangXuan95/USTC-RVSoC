module soc_top (
    // 时钟，要求50MHz
    input  logic clk,
    // 调试器UART信号
    input  logic isp_uart_rx,
    output logic isp_uart_tx,
    // 用户UART信号
    input  logic user_uart_rx,
    output logic user_uart_tx,
    // VGA显示输出信号
    output logic vga_hsync, vga_vsync,
	output logic [15:0] vga_pixel
);
logic rst_n;
logic [31:0] boot_addr;

naive_bus  bus_masters[3]();
naive_bus  bus_slaves[5]();

// 一个能作为naive bus 主设备的调试器
// 它接收用户从UART发来的命令，操控复位等信号，或对总线进行读写。用户可以使用UART命令复位整个SoC，上传程序，或者查看运行时的RAM数据。
isp_uart isp_uart_inst(
    .clk               ( clk            ),
    .i_uart_rx         ( isp_uart_rx    ),
    .o_uart_tx         ( isp_uart_tx    ),
    .o_rst_n           ( rst_n          ),
    .o_boot_addr       ( boot_addr      ),
    .bus               ( bus_masters[0] )
);

// RV32I 核
core_top core_top_inst(
    .clk               ( clk            ),
    .rst_n             ( rst_n          ),
    .i_boot_addr       ( boot_addr      ),
    .instr_master      ( bus_masters[1] ),
    .data_master       ( bus_masters[2] )
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

/*
// 显存 
video_ram video_ram_inst(
    .clk               ( clk            ),
    .rst_n             ( rst_n          ),
    .bus               ( bus_slaves[3]  ),
    .o_vsync           ( vga_vsync      ),
    .o_hsync           ( vga_hsync      ),
    .o_pixel           ( vga_pixel      )
);
*/

// 用户UART
user_uart_tx user_uart_tx_inst(
    .clk               ( clk            ),
    .rst_n             ( rst_n          ),
    .o_uart_tx         ( user_uart_tx   ),
    .bus               ( bus_slaves[4]  )
);


// 3主5从总线仲裁器
//
// 主（越靠前优先级越高）：
//   0. UART调试器
//   1. Core Instr Master
//   2. Core Data  Master
//
// 从：
//   1. 指令ROM， 地址空间 00000000~00000fff
//   2. 指令RAM， 地址空间 00008000~00008fff
//   3. 数据RAM， 地址空间 00010000~00010fff
//   4. 显存RAM， 地址空间 00020000~00020fff
//   5. 用户UART，地址空间 00030000~00030003
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

