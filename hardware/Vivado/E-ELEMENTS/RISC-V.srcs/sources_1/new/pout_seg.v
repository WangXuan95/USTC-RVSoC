module pout_seg (
    input  clk, 
    input  rst_n,
    output [7:0]  SEL,
    output [7:0]  DIG,   
    input  [31:0] rd_data,         
    input  rd_gnt,         
    output wr_req,       
    output [31:0] wr_addr,    
    output [31:0] wr_data,    
    input  wr_gnt  
);

wire [31:0] cell_wr_addr;
wire [ 31:0] wdata;
wire we;
reg [31:0] seg_data;
	
assign we = wr_req;

assign rd_gnt = 1'b0;
assign wr_gnt = wr_req;
assign rd_data = 0;
assign cell_wr_addr = wr_addr[31:2];
assign wdata = wr_data;

always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        seg_data <= 0;
    else if(we && cell_wr_addr == 0)
        seg_data <= wdata;

seg seg0(
            .clk           (clk     ),
            .seg_data      (seg_data),
            .DIG           (DIG     ),
            .SEL           (SEL     )
    );
        
endmodule
