library verilog;
use verilog.vl_types.all;
entity core_ex_branch_judge is
    port(
        i_branch        : in     vl_logic;
        i_num1u         : in     vl_logic_vector(31 downto 0);
        i_num2u         : in     vl_logic_vector(31 downto 0);
        i_funct3        : in     vl_logic_vector(2 downto 0);
        o_branch        : out    vl_logic
    );
end core_ex_branch_judge;
