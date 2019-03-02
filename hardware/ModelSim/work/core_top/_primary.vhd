library verilog;
use verilog.vl_types.all;
entity core_top is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        i_boot_addr     : in     vl_logic_vector(31 downto 0)
    );
end core_top;
