library verilog;
use verilog.vl_types.all;
entity user_uart_tx is
    generic(
        UART_TX_CLK_DIV : integer := 434
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        o_uart_tx       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of UART_TX_CLK_DIV : constant is 1;
end user_uart_tx;
