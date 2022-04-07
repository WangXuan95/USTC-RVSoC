
module isp_uart #(
    parameter  UART_RX_CLK_DIV = 108,   // 50MHz/4/115200Hz=108
    parameter  UART_TX_CLK_DIV = 434    // 50MHz/1/115200Hz=434
)(
    input  logic        clk,
    input  logic        i_uart_rx,
    output logic        o_uart_tx,
    output logic        o_rstn,
    output logic [31:0] o_boot_addr,
    naive_bus.master    bus,
    naive_bus.slave     user_uart_bus
);

logic isp_uart_tx, user_uart_tx, isp_user_sel=1'b0;
logic [ 3:0] rstn_shift = 4'b0;
logic uart_tx_line_fin, rx_ready, rd_ok=1'b0, wr_ok=1'b0, tx_start=1'b0;
logic [ 7:0] rx_data;
logic [31:0] addr=0, wr_data=0;
logic [ 7:0][ 7:0] rd_data_ascii;
logic [ 7:0][ 7:0] tx_data = 64'h0;
enum  {NEW, CMD,OPEN,CLOSE,ADDR, EQUAL, DATA, FINAL, TRASH} fsm = NEW;
enum  {NONE, SELOPEN, SELCLOSE, RST} send_type = NONE;

`define  C  (rx_data=="r") || (rx_data=="R")
`define  OP (rx_data=="o") || (rx_data=="O")
`define  CL (rx_data=="s") || (rx_data=="S")
`define  S  (rx_data==" "  || rx_data=="\t" ) 
`define  E  (rx_data=="\n" || rx_data=="\r" ) 
`define  N  ( (rx_data>="0" && rx_data<="9" ) || (rx_data>="a" && rx_data<="f" ) || (rx_data>="A" && rx_data<="F" ) )

function automatic logic [3:0] ascii2hex(input [7:0] ch);
    logic [7:0] rxbinary;
    if(ch>="0" && ch<="9" ) begin
        rxbinary = ch - "0";
    end else if(ch>="a" && ch<="f" ) begin
        rxbinary = ch - "a" + 8'd10;
    end else if(ch>="A" && ch<="F" ) begin
        rxbinary = ch - "A" + 8'd10;
    end else begin
        rxbinary = 8'h0;
    end
    return rxbinary[3:0];
endfunction

initial o_boot_addr = 0;
assign  o_rstn = rstn_shift[3];
assign  o_uart_tx = isp_user_sel ? isp_uart_tx : user_uart_tx;
initial begin bus.rd_req = 1'b0; bus.wr_req = 1'b0; bus.rd_addr = 0; bus.wr_addr = 0; bus.wr_data = 0; end
assign bus.rd_be = 4'hf;
assign bus.wr_be = 4'hf;

uart_rx #(
    .UART_RX_CLK_DIV   ( UART_RX_CLK_DIV )
) uart_rx_i (
    .clk               ( clk             ),
    .i_rx              ( i_uart_rx       ),
    .o_ready           ( rx_ready        ),
    .o_data            ( rx_data         )
);

uart_tx_line #(
    .UART_TX_CLK_DIV   ( UART_TX_CLK_DIV  )
) uart_tx_line_i (
    .clk               ( clk              ),
    .o_tx              ( isp_uart_tx      ),
    .i_start           ( tx_start         ),
    .o_fin             ( uart_tx_line_fin ),
    .i_data            ( tx_data          )
);

user_uart_tx #(
    .UART_TX_CLK_DIV   ( UART_TX_CLK_DIV  )
) user_uart_in_isp_i (
    .clk               ( clk              ),
    .rstn              ( o_rstn           ),
    .o_uart_tx         ( user_uart_tx     ),
    .bus               ( user_uart_bus    )
);

generate
    genvar i;
    for(i=0; i<8; i++) begin : convert_binary_to_ascii
        always_comb
            if(bus.rd_data[3+4*i:4*i]>4'h9)
                rd_data_ascii[i] = "a" - 8'd10 + bus.rd_data[3+4*i:4*i];
            else
                rd_data_ascii[i] = "0"         + bus.rd_data[3+4*i:4*i];
    end
endgenerate

always @ (posedge clk)
    rd_ok <= (bus.rd_req & bus.rd_gnt);
    
always @ (posedge clk)
    wr_ok <= (bus.wr_req & bus.wr_gnt);
    
// uart send
always @ (posedge clk)
    if         (rd_ok) begin
        tx_start<= 1'b1;
        send_type <= NONE;
        tx_data <= rd_data_ascii;
    end else if(wr_ok) begin
        tx_start<= 1'b1;
        send_type <= NONE;
        tx_data <= "wr done ";
    end else if(rx_ready && `E) begin
        if(isp_user_sel==1'b0) begin
            tx_start<= 1'b1;
            send_type <= SELCLOSE;
            tx_data <= "\r\ndebug ";
        end else if(fsm==CMD) begin
            tx_start<= 1'b1;
            send_type <= RST;
            tx_data <= "rst done";
        end else if(fsm==OPEN) begin
            tx_start<= 1'b1;
            send_type <= SELOPEN;
            tx_data <= "user    ";
        end else if(fsm==TRASH) begin
            tx_start<= 1'b1;
            send_type <= NONE;
            tx_data <= "invalid ";
        end
    end else begin
        tx_start<= 1'b0;
        tx_data <= 64'h0;
    end
    
always @ (posedge clk)
    if(uart_tx_line_fin && send_type == RST)
        rstn_shift <= 4'h0;
    else
        rstn_shift <= {rstn_shift[2:0],1'b1};
        
always @ (posedge clk)
    if(uart_tx_line_fin && (send_type == RST || send_type == SELOPEN) )
        isp_user_sel <= 1'b0;     // user mode
    else if(rx_ready && `E )
        isp_user_sel <= 1'b1;     // debug mode

always @ (posedge clk)
    if         (bus.rd_req) begin
        if(bus.rd_gnt)
            bus.rd_req <= 1'b0;
    end else if(bus.wr_req) begin
        if(bus.wr_gnt)
            bus.wr_req <= 1'b0;
    end else if( rx_ready ) begin
        case(fsm)
        NEW       : if         (`C) begin
                        fsm <= CMD;
                        wr_data <= 0;
                    end else if(`OP) begin
                        fsm <= OPEN;
                    end else if(`S || `E) begin
                        fsm <= NEW;
                        addr <= 0;
                        wr_data <= 0;
                    end else if(`N) begin
                        fsm <= ADDR;
                        addr <= {addr[27:0], ascii2hex(rx_data) };     // get a addr 
                    end else        begin
                        fsm <= TRASH;
                    end
        OPEN      : if         (`E) begin
                        fsm <= NEW;  // cmd open ok!
                    end else if(`S) begin
                        fsm <= OPEN;
                    end else        begin
                        fsm <= TRASH;
                    end
        CMD       : if         (`E) begin
                        o_boot_addr <= {wr_data[31:2],2'b00};
                        fsm <= NEW;  // cmd ok!
                        addr <= 0;
                        wr_data <= 0;
                    end else if(`S) begin
                        fsm <= CMD;
                    end else if(`N) begin
                        fsm <= CMD;
                        wr_data <= {wr_data[27:0], ascii2hex(rx_data) };  // get a data
                    end else        begin
                        fsm <= TRASH;
                    end
        ADDR      : if         (`E) begin
                        fsm <= NEW;   // get a read command
                        bus.rd_req <= 1'b1;   // TODO : launch a bus read 
                        bus.rd_addr <= addr;
                        addr <= 0;
                        wr_data <= 0;
                    end else if(`N) begin
                        fsm <= ADDR;
                        addr <= {addr[27:0], ascii2hex(rx_data) };     // get a addr 
                    end else if(`S) begin
                        fsm <= EQUAL; // get addr down, waiting for data, maybe a write command
                    end else        begin
                        fsm <= TRASH;
                    end
        EQUAL     : if         (`E) begin
                        fsm <= NEW;   // get a read command
                        bus.rd_req <= 1'b1;   // TODO : launch a bus read 
                        bus.rd_addr <= addr;
                        addr <= 0;
                        wr_data <= 0;
                    end else if(`N) begin
                        fsm <= DATA;  // get a data
                        wr_data <= {wr_data[27:0], ascii2hex(rx_data) };  // get a data
                    end else if(`S) begin
                        fsm <= EQUAL;
                    end else        begin
                        fsm <= TRASH;
                    end
        DATA      : if         (`E) begin
                        fsm <= NEW;           // get a write command
                        bus.wr_req <= 1'b1;   // TODO : launch a bus write 
                        bus.wr_addr <= addr;
                        bus.wr_data <= wr_data;
                        addr <= 0;
                        wr_data <= 0;
                    end else if(`N) begin
                        fsm <= DATA;  // get a data
                        wr_data <= {wr_data[27:0], ascii2hex(rx_data) };  // get a data
                    end else if(`S) begin
                        fsm <= FINAL;  // get data down, waiting for \r or \n
                    end else        begin
                        fsm <= TRASH;
                    end
        FINAL     : if         (`E) begin
                        fsm <= NEW;           // get a write command
                        bus.wr_req <= 1'b1;   // TODO : launch a bus write 
                        bus.wr_addr <= addr;
                        bus.wr_data <= wr_data;
                        addr <= 0;
                        wr_data <= 0;
                    end else if(`S) begin
                        fsm <= FINAL;  // get addr down, waiting for \r or \n
                    end else        begin
                        fsm <= TRASH;
                    end
        default   : if         (`E) begin
                        // get a syntax error
                        fsm <= NEW;
                        addr <= 0;
                        wr_data <= 0;
                    end else        begin
                        fsm <= TRASH;
                    end
        endcase
    end

endmodule
