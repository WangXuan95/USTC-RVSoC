library verilog;
use verilog.vl_types.all;
entity ram is
    port(
        clk             : in     vl_logic;
        i_we            : in     vl_logic;
        i_waddr         : in     vl_logic_vector(9 downto 0);
        i_raddr         : in     vl_logic_vector(9 downto 0);
        i_wdata         : in     vl_logic_vector(7 downto 0);
        o_rdata         : out    vl_logic_vector(7 downto 0)
    );
end ram;
