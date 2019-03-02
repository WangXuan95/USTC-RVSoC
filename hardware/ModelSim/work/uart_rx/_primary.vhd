library verilog;
use verilog.vl_types.all;
entity uart_rx is
    generic(
        UART_RX_CLK_DIV : integer := 108
    );
    port(
        clk             : in     vl_logic;
        i_rx            : in     vl_logic;
        o_ready         : out    vl_logic;
        o_data          : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of UART_RX_CLK_DIV : constant is 1;
end uart_rx;
