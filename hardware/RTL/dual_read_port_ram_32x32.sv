module dual_read_port_ram_32x32(            // 32bit*32addr
    input  logic clk,
    input  logic i_we,
    input  logic [ 4:0] i_waddr,
    input  logic [31:0] i_wdata,
    input  logic [ 4:0] i_raddr1,
    output logic [31:0] o_rdata1,
    input  logic [ 4:0] i_raddr2,
    output logic [31:0] o_rdata2
);
initial begin o_rdata1 = 0; o_rdata2 = 0; end

logic [31:0] data_ram_cell [0:31];
    
always @ (posedge clk)
    o_rdata1 <= data_ram_cell[i_raddr1];
    
always @ (posedge clk)
    o_rdata2 <= data_ram_cell[i_raddr2];

always @ (posedge clk)
    if(i_we) 
        data_ram_cell[i_waddr] <= i_wdata;

endmodule
