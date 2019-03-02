library verilog;
use verilog.vl_types.all;
entity video_ram is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        o_hsync         : out    vl_logic;
        o_vsync         : out    vl_logic;
        o_pixel         : out    vl_logic_vector(15 downto 0)
    );
end video_ram;
