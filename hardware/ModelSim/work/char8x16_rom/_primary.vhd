library verilog;
use verilog.vl_types.all;
entity char8x16_rom is
    port(
        clk             : in     vl_logic;
        addr            : in     vl_logic_vector(11 downto 0);
        data            : out    vl_logic_vector(7 downto 0)
    );
end char8x16_rom;
