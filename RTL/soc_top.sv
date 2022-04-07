
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

logic        rstn;
logic [31:0] boot_addr;

naive_bus  bus_masters[3]();
naive_bus  bus_slaves[5]();

// shared debug uart and user uart module
isp_uart  #(
   .UART_RX_CLK_DIV    ( UART_RX_CLK_DIV),
   .UART_TX_CLK_DIV    ( UART_TX_CLK_DIV)
) isp_uart_i(
    .clk               ( clk            ),
    .i_uart_rx         ( isp_uart_rx    ),
    .o_uart_tx         ( isp_uart_tx    ),
    .o_rstn            ( rstn           ),
    .o_boot_addr       ( boot_addr      ),
    .bus               ( bus_masters[0] ),
    .user_uart_bus     ( bus_slaves[4]  )
);


// RV32I Core
core_top core_top_i(
    .clk               ( clk            ),
    .rstn              ( rstn           ),
    .i_boot_addr       ( boot_addr      ),
    .instr_master      ( bus_masters[2] ),
    .data_master       ( bus_masters[1] )
);


// Instruction ROM
instr_rom instr_rom_i(
    .clk               ( clk            ),
    .bus               ( bus_slaves[0]  )
);


// Instruction RAM
ram_bus_wrapper instr_ram_i(
    .clk               ( clk            ),
    .bus               ( bus_slaves[1]  )
);


// Data RAM
ram_bus_wrapper data_ram_i(
    .clk               ( clk            ),
    .bus               ( bus_slaves[2]  )
);


// Video RAM (include VGA controller)
video_ram  #(
    .VGA_CLK_DIV       ( VGA_CLK_DIV    )
) video_ram_i (
    .clk               ( clk            ),
    .rstn              ( rstn           ),
    .bus               ( bus_slaves[3]  ),
    .o_vsync           ( vga_vsync      ),
    .o_hsync           ( vga_hsync      ),
    .o_red             ( vga_red        ),
    .o_green           ( vga_green      ),
    .o_blue            ( vga_blue       )
);


// bus router (bus interconnect)
//
// Bus Masters (sort by priority):
//   0. UART Debugger (isp_uart)
//   1. Core Data Master
//   2. Core Instruction  Master
//
// Bus Slaves:
//   1. Instruction ROM    address: 0x00000000~0x00000fff
//   2. Instruction RAM    address: 0x00008000~0x00008fff
//   3. Data RAM           address: 0x00010000~0x00010fff
//   4. Video RAM          address: 0x00020000~0x00020fff
//   5. user tx uart       address: 0x00030000~0x00030003
naive_bus_router #(
    .N_MASTER          ( 3            ),
    .N_SLAVE           ( 5            ),
    .SLAVES_MASK       ( { 32'h0000_0003 , 32'h0000_0fff , 32'h0000_0fff , 32'h0000_0fff  , 32'h0000_0fff } ),
    .SLAVES_BASE       ( { 32'h0003_0000 , 32'h0002_0000 , 32'h0001_0000 , 32'h0000_8000  , 32'h0000_0000 } )
) soc_bus_router_i (
    .clk               ( clk          ),
    .rstn              ( rstn         ),
    .masters           ( bus_masters  ),
    .slaves            ( bus_slaves   )
);

endmodule

