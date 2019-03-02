library verilog;
use verilog.vl_types.all;
entity soc_top is
    generic(
        UART_RX_CLK_DIV : integer := 108;
        UART_TX_CLK_DIV : integer := 434
    );
    port(
        clk             : in     vl_logic;
        isp_uart_rx     : in     vl_logic;
        isp_uart_tx     : out    vl_logic;
        vga_hsync       : out    vl_logic;
        vga_vsync       : out    vl_logic;
        vga_pixel       : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of UART_RX_CLK_DIV : constant is 1;
    attribute mti_svvh_generic_type of UART_TX_CLK_DIV : constant is 1;
end soc_top;
