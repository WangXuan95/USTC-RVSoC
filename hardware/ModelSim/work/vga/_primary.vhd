library verilog;
use verilog.vl_types.all;
entity vga is
    port(
        clk             : in     vl_logic;
        hsync           : out    vl_logic;
        vsync           : out    vl_logic;
        pixel           : out    vl_logic_vector(15 downto 0);
        req             : out    vl_logic;
        x               : out    vl_logic_vector(9 downto 0);
        y               : out    vl_logic_vector(9 downto 0);
        req_pixel       : in     vl_logic_vector(15 downto 0)
    );
end vga;
