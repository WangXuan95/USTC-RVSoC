library verilog;
use verilog.vl_types.all;
entity naive_bus_router is
    generic(
        N_MASTER        : vl_logic_vector(7 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        N_SLAVE         : vl_logic_vector(7 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1);
        SLAVES_MASK     : vl_logic_vector;
        SLAVES_BASE     : vl_logic_vector
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N_MASTER : constant is 2;
    attribute mti_svvh_generic_type of N_SLAVE : constant is 2;
    attribute mti_svvh_generic_type of SLAVES_MASK : constant is 4;
    attribute mti_svvh_generic_type of SLAVES_BASE : constant is 4;
end naive_bus_router;
