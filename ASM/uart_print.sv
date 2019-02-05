// asm file name: uart_print.S
module instr_rom(
    input  logic clk, rst_n,
    naive_bus.slave  bus
);
    localparam  INSTR_CNT = 30'd20;
    
    wire [0:INSTR_CNT-1] [31:0] instr_rom_cell = {
