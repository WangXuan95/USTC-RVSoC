
module core_regfile(
    input  logic clk, rstn,
    input  logic rd_latch,
    // Read  port 1
    input  logic i_re1,
    input  logic [4:0]  i_raddr1,
    output logic [31:0] o_rdata1,
    // Read  port 2
    input  logic i_re2,
    input  logic [4:0]  i_raddr2,
    output logic [31:0] o_rdata2,
    // forward port 1
    input  logic i_forward1,
    input  logic [4:0] i_faddr1,
    input  logic [31:0] i_fdata1,
    // forward port 2
    input  logic i_forward2,  
    input  logic [4:0] i_faddr2,
    input  logic [31:0] i_fdata2,
    // Write port
    input  logic i_we,
    input  logic [4:0] i_waddr,
    input  logic [31:0] i_wdata
);

logic [31:0] reg_rdata1 = 0;
logic [31:0] reg_rdata2 = 0;
logic [31:0] forward_data1, forward_data2;
logic from_fw1, from_fw2;

assign o_rdata1 = from_fw1 ? forward_data1 : reg_rdata1;
assign o_rdata2 = from_fw2 ? forward_data2 : reg_rdata2;

always @ (posedge clk or negedge rstn)
    if(~rstn) begin
        from_fw1 <= 1'b0;
        forward_data1 <= 0;
    end else begin
        if(rd_latch) begin
            from_fw1 <= 1'b1;
            forward_data1 <= o_rdata1;
        end else if((~i_re1)   || i_raddr1==5'h0    ) begin
            from_fw1 <= 1'b1;
            forward_data1 <= 0;
        end else if(i_forward1 && i_faddr1==i_raddr1) begin
            from_fw1 <= 1'b1;
            forward_data1 <= i_fdata1;
        end else if(i_forward2 && i_faddr2==i_raddr1) begin
            from_fw1 <= 1'b1;
            forward_data1 <= i_fdata2;
        end else if(i_we       && i_waddr ==i_raddr1) begin
            from_fw1 <= 1'b1;
            forward_data1 <= i_wdata;
        end else begin
            from_fw1 <= 1'b0;
            forward_data1 <= 0;
        end
    end

always @ (posedge clk or negedge rstn)
    if(~rstn) begin
        from_fw2 <= 1'b0;
        forward_data2 <= 0;
    end else begin
        if(rd_latch) begin
            from_fw2 <= 1'b1;
            forward_data2 <= o_rdata2;
        end else if((~i_re2)   || i_raddr2==5'h0    ) begin
            from_fw2 <= 1'b1;
            forward_data2 <= 0;
        end else if(i_forward1 && i_faddr1==i_raddr2) begin
            from_fw2 <= 1'b1;
            forward_data2 <= i_fdata1;
        end else if(i_forward2 && i_faddr2==i_raddr2) begin
            from_fw2 <= 1'b1;
            forward_data2 <= i_fdata2;
        end else if(i_we       && i_waddr ==i_raddr2) begin
            from_fw2 <= 1'b1;
            forward_data2 <= i_wdata;
        end else begin
            from_fw2 <= 1'b0;
            forward_data2 <= 0;
        end
    end


// 32bit * 32 regfile
logic [31:0] regfile [32];
    
always @ (posedge clk)
    reg_rdata1 <= regfile[i_raddr1];
    
always @ (posedge clk)
    reg_rdata2 <= regfile[i_raddr2];

always @ (posedge clk)
    if(i_we) 
        regfile[i_waddr] <= i_wdata;

endmodule
