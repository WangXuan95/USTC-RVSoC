library verilog;
use verilog.vl_types.all;
entity core_regfile is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        rd_latch        : in     vl_logic;
        i_re1           : in     vl_logic;
        i_raddr1        : in     vl_logic_vector(4 downto 0);
        o_rdata1        : out    vl_logic_vector(31 downto 0);
        i_re2           : in     vl_logic;
        i_raddr2        : in     vl_logic_vector(4 downto 0);
        o_rdata2        : out    vl_logic_vector(31 downto 0);
        i_we1           : in     vl_logic;
        i_waddr1        : in     vl_logic_vector(4 downto 0);
        i_wdata1        : in     vl_logic_vector(31 downto 0);
        i_we2           : in     vl_logic;
        i_waddr2        : in     vl_logic_vector(4 downto 0);
        i_wdata2        : in     vl_logic_vector(31 downto 0);
        i_we3           : in     vl_logic;
        i_waddr3        : in     vl_logic_vector(4 downto 0);
        i_wdata3        : in     vl_logic_vector(31 downto 0)
    );
end core_regfile;
