
module user_uart_tx #(
    parameter  UART_TX_CLK_DIV = 434    // 50MHz/1/115200Hz=434
)(
    input  logic     clk, rst_n,
    output logic     o_uart_tx,
    naive_bus.slave  bus
);
localparam TX_CNT = 5'd19;

logic [ 9:0] fifo_rd_pointer=10'h0, fifo_wr_pointer=10'h0, fifo_len;
logic fifo_full, fifo_empty;
logic rd_addr_valid, wr_addr_valid;
logic [31:0] cnt = 0;
logic [ 4:0] tx_cnt = 0;
logic [ 7:0] tx_shift = 8'h0;
logic [ 7:0] fifo_rd_data;

initial o_uart_tx = 1'b1;

assign rd_addr_valid = (bus.rd_addr[31:2] == 30'h0);
assign wr_addr_valid = (bus.wr_addr[31:2] == 30'h0);

assign fifo_len = fifo_wr_pointer - fifo_rd_pointer;
assign fifo_empty = (fifo_len==10'h000);
assign fifo_full  = (fifo_len==10'h3ff);

assign bus.rd_gnt = bus.rd_req;

always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        bus.rd_data <= 0;
    else begin
        if(bus.rd_req & rd_addr_valid)
            bus.rd_data <= {22'h0, fifo_len};
        else
            bus.rd_data <= 0;
    end

always_comb
    if(bus.wr_req) begin
        if(wr_addr_valid && bus.wr_be[0]) begin
            bus.wr_gnt <= ~fifo_full;
        end else begin
            bus.wr_gnt <= 1'b1;
        end
    end else begin
        bus.wr_gnt <= 1'b0;
    end

always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        fifo_wr_pointer <= 10'h0;
    end else begin
        if(bus.wr_req & wr_addr_valid & bus.wr_be[0] & ~fifo_full) begin
            fifo_wr_pointer <= fifo_wr_pointer + 10'h1;
        end
    end

always @ (posedge clk or negedge rst_n)
    if(~rst_n)
        cnt <= 0;
    else
        cnt <= (cnt<UART_TX_CLK_DIV-1) ? cnt+1 : 0;

always @ (posedge clk or negedge rst_n)
    if(~rst_n) begin
        fifo_rd_pointer <= 10'h0;
        o_uart_tx       <= 1'b1;
        tx_shift        <= 8'h00;
        tx_cnt          <= 5'h0;
    end else begin
        if(tx_cnt>5'd0) begin
            if(cnt==0) begin
                if(tx_cnt==TX_CNT) begin
                    {tx_shift, o_uart_tx} <= ~{fifo_rd_data, 1'b1};
                    fifo_rd_pointer <= fifo_rd_pointer + 10'h1;
                end else begin
                    {tx_shift, o_uart_tx} <= {1'b0, tx_shift[7:1], ~tx_shift[0]};
                end
                tx_cnt <= tx_cnt - 5'd1;
            end
        end else begin
            o_uart_tx <= 1'b1;
            tx_cnt <= fifo_empty ? 5'd0 : TX_CNT;
        end
    end
    
ram ram_for_uart_tx_fifo_inst(
    .clk       ( clk              ),
    .i_we      ( bus.wr_req & wr_addr_valid & bus.wr_be[0] & ~fifo_full ),
    .i_waddr   ( fifo_wr_pointer  ),
    .i_wdata   ( bus.wr_data[7:0] ),
    .i_raddr   ( fifo_rd_pointer  ),
    .o_rdata   ( fifo_rd_data     )
);

endmodule
