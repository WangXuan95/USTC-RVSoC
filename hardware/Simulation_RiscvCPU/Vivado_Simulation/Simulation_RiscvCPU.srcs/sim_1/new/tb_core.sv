//--------------------------------------------------------------------------------------------------------------
// This project runs RISC-V official ISA test
//     see https://github.com/riscv/riscv-tests
//--------------------------------------------------------------------------------------------------------------

`timescale 1ns / 1ns

module tb_core #(
    // Specify the instruction&data stream file to be tested here
    // We modified RISC-V official ISA test into 3 small tests (In path USTCRVSoC/hardware/Simulation_RiscvCPU/RISCV_RV32I_Test)
    
    // notice: this is the file-path in my computer, dont forget to modify it
    parameter INSTRUCTION_STREAM_FILE = "E:\\FPGAcommon\\USTCRVSoC\\hardware\\Simulation_RiscvCPU\\RISCV_RV32I_Test\\testA_InstructionStream.txt"
                                     // "E:\\FPGAcommon\\USTCRVSoC\\hardware\\Simulation_RiscvCPU\\RISCV_RV32I_Test\\testB_InstructionStream.txt"
                                     // "E:\\FPGAcommon\\USTCRVSoC\\hardware\\Simulation_RiscvCPU\\RISCV_RV32I_Test\\testC_InstructionStream.txt"
)();

logic [31:0] ram [4096]; // this ram stores both instruction and data

initial $readmemh(INSTRUCTION_STREAM_FILE, ram);

logic clk = 1'b1, rst_n = 1'b0;
always  #5  clk = ~clk;   // 100MHz clock
initial #40 rst_n = 1'b1;

naive_bus  bus_masters[2]();
naive_bus  bus_slaves [1]();

// RV32I Core
core_top core_top_inst(
    .clk          ( clk               ),
    .rst_n        ( rst_n             ),
    .i_boot_addr  ( 0                 ),
    .instr_master ( bus_masters[1]    ),
    .data_master  ( bus_masters[0]    )
);

naive_bus_router #(
    .N_MASTER     ( 2                 ),
    .N_SLAVE      ( 1                 ),
    .SLAVES_MASK  ( { 32'h0000_ffff } ),
    .SLAVES_BASE  ( { 32'h0000_0000 } )
) soc_bus_router_inst (
    .clk          ( clk               ),
    .rst_n        ( rst_n             ),
    .masters      ( bus_masters       ),
    .slaves       ( bus_slaves        )
);

assign bus_slaves[0].rd_gnt = 1'b1;
assign bus_slaves[0].wr_gnt = 1'b1;

always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        bus_slaves[0].rd_data <= 0;
    else
        bus_slaves[0].rd_data <= ram[bus_slaves[0].rd_addr[14:2]];
    
always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
    end else begin
        if(bus_slaves[0].wr_be[0])
            ram[bus_slaves[0].wr_addr[14:2]][ 7: 0] <= bus_slaves[0].wr_data[ 7: 0];
        if(bus_slaves[0].wr_be[1])
            ram[bus_slaves[0].wr_addr[14:2]][15: 8] <= bus_slaves[0].wr_data[15: 8];
        if(bus_slaves[0].wr_be[2])
            ram[bus_slaves[0].wr_addr[14:2]][23:16] <= bus_slaves[0].wr_data[23:16];
        if(bus_slaves[0].wr_be[3])
            ram[bus_slaves[0].wr_addr[14:2]][31:24] <= bus_slaves[0].wr_data[31:24];
    end

endmodule
