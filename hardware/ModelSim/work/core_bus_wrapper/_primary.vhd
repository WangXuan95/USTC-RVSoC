library verilog;
use verilog.vl_types.all;
entity core_bus_wrapper is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        i_en_n          : in     vl_logic;
        i_re            : in     vl_logic;
        i_we            : in     vl_logic;
        o_conflict      : out    vl_logic;
        o_conflict_latch: out    vl_logic;
        i_funct3        : in     vl_logic_vector(2 downto 0);
        i_addr          : in     vl_logic_vector(31 downto 0);
        i_wdata         : in     vl_logic_vector(31 downto 0);
        o_rdata         : out    vl_logic_vector(31 downto 0)
    );
end core_bus_wrapper;
