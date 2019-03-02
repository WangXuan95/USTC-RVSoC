library verilog;
use verilog.vl_types.all;
entity instr_rom is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic
    );
end instr_rom;
