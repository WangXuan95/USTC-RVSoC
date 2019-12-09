module ram128B(            // 128B
    input  logic clk,
    input  logic i_we,
    input  logic [ 6:0] i_addr,
    input  logic [ 7:0] i_wdata,
    output logic [ 7:0] o_rdata
);
initial o_rdata = 8'h0;

logic [7:0] data_ram_cell [0:127];
    
always @ (posedge clk)
    o_rdata <= data_ram_cell[i_addr];

always @ (posedge clk)
    if(i_we) 
        data_ram_cell[i_addr] <= i_wdata;

endmodule