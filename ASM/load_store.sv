// asm file name: load_store.S
module instr_rom(
    input  logic clk, rst_n,
    input  logic [13:0] i_addr,
    output logic [31:0] o_data
);
    localparam  INSTR_CNT = 12'd30;
    
    wire [0:INSTR_CNT-1] [31:0] instr_rom_cell = {
        32'h20006513,    //0x00000000
        32'h0c800593,    //0x00000004
        32'h05600613,    //0x00000008
        32'h0a400693,    //0x0000000c
        32'h01200713,    //0x00000010
        32'h00b50023,    //0x00000014
        32'h00c500a3,    //0x00000018
        32'h00d50123,    //0x0000001c
        32'h00e501a3,    //0x00000020
        32'h00052283,    //0x00000024
        32'h00050283,    //0x00000028
        32'h00150283,    //0x0000002c
        32'h00250283,    //0x00000030
        32'h00350283,    //0x00000034
        32'h00054283,    //0x00000038
        32'h00154283,    //0x0000003c
        32'h00254283,    //0x00000040
        32'h00354283,    //0x00000044
        32'h00051283,    //0x00000048
        32'h00251283,    //0x0000004c
        32'h00050283,    //0x00000050
        32'h00250283,    //0x00000054
        32'h123457b7,    //0x00000058
        32'h67878793,    //0x0000005c
        32'h00f51823,    //0x00000060
        32'h01000293,    //0x00000064
        32'h0107d813,    //0x00000068
        32'h0057d8b3,    //0x0000006c
        32'h01151923,    //0x00000070
        32'h0000006f     //0x00000074
    };
    
    logic [11:0] instr_index;
    logic [31:0] data;
    
    assign instr_index = i_addr[13:2];
    assign data = (instr_index>=INSTR_CNT) ? 0 : instr_rom_cell[instr_index];
    
    always @ (posedge clk or negedge rst_n)
        if(~rst_n)
            o_data <= 0;
        else
            o_data <= data;

endmodule
