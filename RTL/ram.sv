module ram(            // 1024B
    input  logic clk, rst_n,
    input  logic i_we,
    input  logic [ 9:0] i_waddr, i_raddr, i_raddr2,
    input  logic [ 7:0] i_wdata,
    output logic [ 7:0] o_rdata, o_rdata2
);

initial begin o_rdata = 8'h0; o_rdata2 = 8'h0; end

localparam  SIZE = 1024;
logic [SIZE-1:0] [7:0] data_ram_cell;
    
always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        o_rdata <= 0;
    else
        o_rdata <= data_ram_cell[i_raddr];
        
always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        o_rdata2 <= 0;
    else
        o_rdata2 <= data_ram_cell[i_raddr2];

always @ (posedge clk)
    if(i_we) 
        data_ram_cell[i_waddr] <= i_wdata;

endmodule
