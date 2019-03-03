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
        i_forward1      : in     vl_logic;
        i_faddr1        : in     vl_logic_vector(4 downto 0);
        i_fdata1        : in     vl_logic_vector(31 downto 0);
        i_forward2      : in     vl_logic;
        i_faddr2        : in     vl_logic_vector(4 downto 0);
        i_fdata2        : in     vl_logic_vector(31 downto 0);
        i_we            : in     vl_logic;
        i_waddr         : in     vl_logic_vector(4 downto 0);
        i_wdata         : in     vl_logic_vector(31 downto 0)
    );
end core_regfile;
