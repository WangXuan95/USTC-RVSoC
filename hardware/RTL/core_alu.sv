module core_alu(
    input  logic [ 6:0] i_opcode, i_funct7,
    input  logic [ 2:0] i_funct3,
    input  logic [31:0] i_num1u, i_num2u, i_immu,
    output logic [31:0] o_res
);

logic [4:0] shamt_rs, shamt_imm;
logic [31:0] shifted;
logic signed [31:0] i_num1s, i_num2s, i_imms;

assign shamt_imm = i_immu[4:0];
assign shamt_rs  = i_num2u[4:0];
assign i_num1s = i_num1u;
assign i_num2s = i_num2u;
assign i_imms  = i_immu;

always_comb
    casex({i_funct7,i_funct3,i_opcode})
        // 算术类
        17'b0000000_000_0110011 : o_res <=  i_num1u +  i_num2u;   // ADD
        17'bxxxxxxx_000_0010011 : o_res <=  i_num1u +  i_immu ;   // ADDI
        17'b0100000_000_0110011 : o_res <=  i_num1u -  i_num2u;   // SUB
        // LUI类
        17'bxxxxxxx_xxx_0110111 : o_res <=  i_immu;               // LUI
        // 逻辑类
        17'b0000000_100_0110011 : o_res <=  i_num1u ^  i_num2u;   // XOR
        17'bxxxxxxx_100_0010011 : o_res <=  i_num1u ^  i_immu ;   // XORI
        17'b0000000_110_0110011 : o_res <=  i_num1u |  i_num2u;   // OR
        17'bxxxxxxx_110_0010011 : o_res <=  i_num1u |  i_immu ;   // ORI
        17'b0000000_111_0110011 : o_res <=  i_num1u &  i_num2u;   // AND
        17'bxxxxxxx_111_0010011 : o_res <=  i_num1u &  i_immu ;   // ANDI
        // 位移类
        17'b0000000_001_0110011 : o_res <=  i_num1u << shamt_rs ; // SLL
        17'b0000000_001_0010011 : o_res <=  i_num1u << shamt_imm; // SLLI
        17'b0000000_101_0110011 : o_res <=  i_num1u >> shamt_rs ; // SRL
        17'b0000000_101_0010011 : o_res <=  i_num1u >> shamt_imm; // SRL
        17'b0100000_101_0110011 : o_res <=  i_num1s >> shamt_rs ; // SRA
        17'b0100000_101_0010011 : o_res <=  i_num1s >> shamt_imm; // SRAI
        // 比较类
        17'b0000000_010_0110011 : o_res <=  (i_num1s < i_num2s) ? 1 : 0;   // SLT
        17'bxxxxxxx_010_0010011 : o_res <=  (i_num1s < i_imms ) ? 1 : 0;   // SLTI
        17'b0000000_011_0110011 : o_res <=  (i_num1u < i_num2u) ? 1 : 0;   // SLTU
        17'bxxxxxxx_011_0010011 : o_res <=  (i_num1u < i_immu ) ? 1 : 0;   // SLTIU
        // 无操作 
        default   : o_res <= 0;
    endcase

endmodule
