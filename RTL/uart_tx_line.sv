
module uart_tx_line #(
    parameter  UART_TX_CLK_DIV = 434    // 50MHz/1/115200Hz=434
)(
    input  logic       clk,
    output logic       o_tx,
    input  logic       i_start,
    input  logic [7:0][7:0] i_data 
);

logic [31:0] cnt = 0;
logic [ 6:0] tx_cnt = 0;
logic [90:0] tx_buffer, tx_shift;
initial tx_shift = 91'h0;
initial o_tx = 1'b1;

assign tx_buffer = {2'b11, 8'h0A  ,   // 0x0A = \n , a end of line
                    2'b01, i_data[0], 
                    2'b01, i_data[1],
                    2'b01, i_data[2], 
                    2'b01, i_data[3], 
                    2'b01, i_data[4], 
                    2'b01, i_data[5], 
                    2'b01, i_data[6], 
                    2'b01, i_data[7], 
                    1'b0};
                    
always @ (posedge clk)
    cnt <= (cnt<UART_TX_CLK_DIV-1) ? cnt+1 : 0;

always @ (posedge clk)
    if(tx_cnt>7'd0) begin
        if(cnt==0) begin
            {tx_shift, o_tx} <= {1'b1, tx_shift};
            tx_cnt <= tx_cnt - 7'd1;
        end
    end else begin
        o_tx <= 1'b1;
        if(i_start) begin
            tx_cnt   <= 7'd93;
            tx_shift <= tx_buffer;
        end else begin
            tx_cnt   <= 7'd0;
        end
    end

endmodule
