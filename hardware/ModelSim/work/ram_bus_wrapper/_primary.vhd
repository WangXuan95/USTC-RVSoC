library verilog;
use verilog.vl_types.all;
entity ram_bus_wrapper is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic
    );
end ram_bus_wrapper;
