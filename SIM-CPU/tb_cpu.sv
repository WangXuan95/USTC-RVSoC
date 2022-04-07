
`timescale 1ps/1ps

module tb_cpu #(
    // Specify the instruction&data stream file to be run here
    // notice: this is the file path in my PC, please modify it to the path in your PC
    parameter INSTRUCTION_STREAM_FILE = "E:/FPGAcommon/USTC-RVSoC/SIM-CPU/rv32i_test/a_instr_stream.txt"  // I provide three test instruction streams here, which are split from the official test of RISC-V RV32I
                                                                                //   b_instr_stream.txt"
                                                                                //   c_instr_stream.txt"
)();

logic clk  = 1'b1;
logic rstn = 1'b0;
always  #10000  clk = ~clk;   // 50MHz clock
initial begin repeat(4) @(posedge clk); rstn <= 1'b1; end

naive_bus  bus_masters[2]();
naive_bus  bus_slaves [1]();

// RV32I Core
core_top core_top_i (
    .clk          ( clk               ),
    .rstn         ( rstn              ),
    .i_boot_addr  ( 0                 ),
    .instr_master ( bus_masters[1]    ),
    .data_master  ( bus_masters[0]    )
);

naive_bus_router #(
    .N_MASTER     ( 2                 ),
    .N_SLAVE      ( 1                 ),
    .SLAVES_MASK  ( { 32'h0000_ffff } ),
    .SLAVES_BASE  ( { 32'h0000_0000 } )
) soc_bus_router_i (
    .clk          ( clk               ),
    .rstn         ( rstn              ),
    .masters      ( bus_masters       ),
    .slaves       ( bus_slaves        )
);

assign bus_slaves[0].rd_gnt = 1'b1;
assign bus_slaves[0].wr_gnt = 1'b1;


//----------------------------------------------------------------------------------------------------------
// this ram stores both instruction and data
//----------------------------------------------------------------------------------------------------------
logic [31:0] ram [4096]; 

initial $readmemh(INSTRUCTION_STREAM_FILE, ram);

always @ (posedge clk or negedge rstn)
    if(~rstn)
        bus_slaves[0].rd_data <= 0;
    else
        bus_slaves[0].rd_data <= ram[bus_slaves[0].rd_addr[14:2]];
    
always @ (posedge clk) begin
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
