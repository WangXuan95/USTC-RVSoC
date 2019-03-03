library verilog;
use verilog.vl_types.all;
entity video_ram is
    generic(
        VGA_CLK_DIV     : integer := 1
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        o_hsync         : out    vl_logic;
        o_vsync         : out    vl_logic;
        o_red           : out    vl_logic;
        o_green         : out    vl_logic;
        o_blue          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of VGA_CLK_DIV : constant is 1;
end video_ram;
