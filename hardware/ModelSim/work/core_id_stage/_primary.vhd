library verilog;
use verilog.vl_types.all;
entity core_id_stage is
    port(
        i_instr         : in     vl_logic_vector(31 downto 0);
        i_pc            : in     vl_logic_vector(31 downto 0);
        o_rs1_addr      : out    vl_logic_vector(4 downto 0);
        o_rs2_addr      : out    vl_logic_vector(4 downto 0);
        o_rs1_en        : out    vl_logic;
        o_rs2_en        : out    vl_logic;
        o_jal           : out    vl_logic;
        o_jalr          : out    vl_logic;
        o_branch_may    : out    vl_logic;
        o_nextpc2reg    : out    vl_logic;
        o_alures2reg    : out    vl_logic;
        o_memory2reg    : out    vl_logic;
        o_mem_write     : out    vl_logic;
        o_pc_plus_imm   : out    vl_logic_vector(31 downto 0);
        o_imm           : out    vl_logic_vector(31 downto 0);
        o_dst_reg_addr  : out    vl_logic_vector(4 downto 0);
        o_opcode        : out    vl_logic_vector(6 downto 0);
        o_funct7        : out    vl_logic_vector(6 downto 0);
        o_funct3        : out    vl_logic_vector(2 downto 0);
        o_next_pc       : out    vl_logic_vector(31 downto 0)
    );
end core_id_stage;
