library verilog;
use verilog.vl_types.all;
entity uart_tx_line is
    generic(
        UART_TX_CLK_DIV : integer := 434
    );
    port(
        clk             : in     vl_logic;
        o_tx            : out    vl_logic;
        i_start         : in     vl_logic;
        o_fin           : out    vl_logic;
        i_data          : in     vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of UART_TX_CLK_DIV : constant is 1;
end uart_tx_line;
