// Priority : Write Port 1 > Write Port 2 > Write Port 3
module core_regfile(
    input  logic clk, rst_n,
    input  logic rd_latch,
    // Read  port 1
    input  logic i_re1,
    input  logic [4:0]  i_raddr1,
    output logic [31:0] o_rdata1,
    // Read  port 2
    input  logic i_re2,
    input  logic [4:0]  i_raddr2,
    output logic [31:0] o_rdata2,
    // Write port 1
    input  logic i_we1,
    input  logic [4:0] i_waddr1,
    input  logic [31:0] i_wdata1,
    // Write port 2
    input  logic i_we2,  
    input  logic [4:0] i_waddr2,
    input  logic [31:0] i_wdata2,
    // Write port 3
    input  logic i_we3,
    input  logic [4:0] i_waddr3,
    input  logic [31:0] i_wdata3
);

logic [31:1] [31:0] reg_file_cell = 992'h0;

// handle regwrite
always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)
        reg_file_cell <= 992'h0;
    else begin
        if(i_we3 && i_waddr3!=5'h0 && ~(i_we1 && i_waddr1==i_waddr3) && ~(i_we2 && i_waddr2==i_waddr3) )
            reg_file_cell[i_waddr3] <= i_wdata3;
        if(i_we2 && i_waddr2!=5'h0 && ~(i_we1 && i_waddr1==i_waddr2) )
            reg_file_cell[i_waddr2] <= i_wdata2;
        if(i_we1 && i_waddr1!=5'h0 )
            reg_file_cell[i_waddr1] <= i_wdata1;
    end
end


always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)
        o_rdata1 <= 0;
    else begin
        if(rd_latch) begin
            o_rdata1 <= o_rdata1;
        end else if(i_re1 && i_raddr1!=5'h0) begin
            if     (i_we1 && i_raddr1==i_waddr1)
                o_rdata1 <= i_wdata1;
            else if(i_we2 && i_raddr1==i_waddr2)
                o_rdata1 <= i_wdata2;
            else if(i_we3 && i_raddr1==i_waddr3)
                o_rdata1 <= i_wdata3;
            else
                o_rdata1 <= reg_file_cell[i_raddr1];
        end else
            o_rdata1 <= 0;
    end
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)
        o_rdata2 <= 0;
    else begin
        if(rd_latch) begin
            o_rdata2 <= o_rdata2;
        end else if(i_re2 && i_raddr2!=5'h0) begin
            if     (i_we1 && i_raddr2==i_waddr1)
                o_rdata2 <= i_wdata1;
            else if(i_we2 && i_raddr2==i_waddr2)
                o_rdata2 <= i_wdata2;
            else if(i_we3 && i_raddr2==i_waddr3)
                o_rdata2 <= i_wdata3;
            else
                o_rdata2 <= reg_file_cell[i_raddr2];
        end else
            o_rdata2 <= 0;
    end
end

endmodule
