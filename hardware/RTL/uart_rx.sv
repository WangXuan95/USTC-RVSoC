module uart_rx #(
    parameter  UART_RX_CLK_DIV = 108   // 50MHz/4/115200Hz=108
)(
    input  logic       clk,
    input  logic       i_rx,
    output logic       o_ready,
    output logic [7:0] o_data
);

logic rx_bit, busy, last_busy=1'b0;
logic [ 5:0] shift = 6'h0, status = 6'h0;
logic [ 7:0] databuf = 8'h0;
logic [31:0] cnt = 0;

initial o_ready = 1'b0;
initial o_data  = 8'h0;

assign busy = (status!=6'h0);
assign rx_bit = (shift[0]&shift[1]) | (shift[0]&i_rx) | (shift[1]&i_rx);

always @ (posedge clk)
    last_busy <= busy;
    
always @ (posedge clk)
    o_ready <= (~busy & last_busy);

always @ (posedge clk)
    cnt <= (cnt<UART_RX_CLK_DIV-1) ? cnt+1 : 0;

always @ (posedge clk)
    if(cnt==0) begin
        if(~busy) begin
            if(shift == 6'b111000)
                status <= 6'h1;
        end else begin
            if(status[5] == 1'b0) begin
                if(status[1:0] == 2'b11)
                    databuf <= {rx_bit, databuf[7:1]};
                status <= status + 6'h1;
            end else begin
                if(status<62) begin
                    status <= 6'd62;
                    o_data <= databuf;
                end else begin
                    status <= status + 6'd1;
                end
            end
        end
        shift <= shift<<1;
        shift[0] <= i_rx;
    end

endmodule
