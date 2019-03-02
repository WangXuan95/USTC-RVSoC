library verilog;
use verilog.vl_types.all;
entity core_alu is
    port(
        i_opcode        : in     vl_logic_vector(6 downto 0);
        i_funct7        : in     vl_logic_vector(6 downto 0);
        i_funct3        : in     vl_logic_vector(2 downto 0);
        i_num1u         : in     vl_logic_vector(31 downto 0);
        i_num2u         : in     vl_logic_vector(31 downto 0);
        i_immu          : in     vl_logic_vector(31 downto 0);
        o_res           : out    vl_logic_vector(31 downto 0)
    );
end core_alu;
