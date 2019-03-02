library verilog;
use verilog.vl_types.all;
entity char8x16_rom is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        ascii           : in     vl_logic_vector(7 downto 0);
        x               : in     vl_logic_vector(2 downto 0);
        y               : in     vl_logic_vector(3 downto 0);
        b               : out    vl_logic
    );
end char8x16_rom;
