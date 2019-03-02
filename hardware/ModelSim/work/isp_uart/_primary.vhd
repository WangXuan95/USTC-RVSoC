library verilog;
use verilog.vl_types.all;
entity isp_uart is
    generic(
        UART_RX_CLK_DIV : integer := 108;
        UART_TX_CLK_DIV : integer := 434
    );
    port(
        clk             : in     vl_logic;
        i_uart_rx       : in     vl_logic;
        o_uart_tx       : out    vl_logic;
        o_rst_n         : out    vl_logic;
        o_boot_addr     : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of UART_RX_CLK_DIV : constant is 1;
    attribute mti_svvh_generic_type of UART_TX_CLK_DIV : constant is 1;
end isp_uart;
