library verilog;
use verilog.vl_types.all;
entity vgaChar98x36 is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        hsync           : out    vl_logic;
        vsync           : out    vl_logic;
        pixel           : out    vl_logic_vector(15 downto 0);
        addr            : out    vl_logic_vector(11 downto 0);
        ascii           : in     vl_logic_vector(7 downto 0)
    );
end vgaChar98x36;
