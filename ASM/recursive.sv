// asm file name: recursive.S
module instr_rom(
    input  logic clk, rst_n,
    input  logic [13:0] i_addr,
    output logic [31:0] o_data
);
    localparam  INSTR_CNT = 12'd31;
    
    wire [0:INSTR_CNT-1] [31:0] instr_rom_cell = {
        32'h12300013,    //0x00000000
        32'h45600013,    //0x00000004
        32'h00010137,    //0x00000008
        32'h40016113,    //0x0000000c
        32'h00604293,    //0x00000010
        32'h00c000ef,    //0x00000014
        32'h00034593,    //0x00000018
        32'h05c0006f,    //0x0000001c
        32'h00306513,    //0x00000020
        32'h00a2f663,    //0x00000024
        32'h0002e313,    //0x00000028
        32'h00008067,    //0x0000002c
        32'hffc10113,    //0x00000030
        32'h00112023,    //0x00000034
        32'hfff28293,    //0x00000038
        32'hffc10113,    //0x0000003c
        32'h00512023,    //0x00000040
        32'hfddff0ef,    //0x00000044
        32'h00012283,    //0x00000048
        32'h00410113,    //0x0000004c
        32'hfff28293,    //0x00000050
        32'hffc10113,    //0x00000054
        32'h00612023,    //0x00000058
        32'hfc5ff0ef,    //0x0000005c
        32'h00012383,    //0x00000060
        32'h00410113,    //0x00000064
        32'h00730333,    //0x00000068
        32'h00012083,    //0x0000006c
        32'h00410113,    //0x00000070
        32'h00008067,    //0x00000074
        32'h0000006f     //0x00000078
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
