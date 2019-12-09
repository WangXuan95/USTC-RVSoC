module core_alu(
    input  logic [ 6:0] i_opcode, i_funct7,
    input  logic [ 2:0] i_funct3,
    input  logic [31:0] i_num1u, i_num2u, i_pc, i_immu,
    output logic o_branch_jalr,
    output logic [31:0] o_res, o_branch_jalr_target
);
logic [ 4:0] shamt_rs, shamt_imm;
logic [31:0] num1_plus_imm, pc_plus_imm;
logic signed [31:0] i_num1s, i_num2s, i_imms;

assign shamt_imm     = i_immu[4:0];
assign shamt_rs      = i_num2u[4:0];
assign num1_plus_imm = i_num1u + i_immu;
assign pc_plus_imm   = i_pc    + i_immu;
assign i_num1s       = i_num1u;
assign i_num2s       = i_num2u;
assign i_imms        = i_immu;

always_comb
    case(i_opcode)
        7'b1100111 : begin                       // JALR
                         o_branch_jalr <= 1'b1;
                         o_branch_jalr_target <= num1_plus_imm;
                     end
        7'b1100011 : begin                       // BRANCHç±?
                         case(i_funct3)
                             3'b000 : o_branch_jalr <= (i_num1u == i_num2u);   // BEQ
                             3'b001 : o_branch_jalr <= (i_num1u != i_num2u);   // BNE
                             3'b100 : o_branch_jalr <= (i_num1s <  i_num2s);   // BLT
                             3'b101 : o_branch_jalr <= (i_num1s >= i_num2s);   // BGE
                             3'b110 : o_branch_jalr <= (i_num1u <  i_num2u);   // BLTU
                             3'b111 : o_branch_jalr <= (i_num1u >= i_num2u);   // BGEU
                             default: o_branch_jalr <= 1'b0;
                         endcase
                         o_branch_jalr_target <= pc_plus_imm;
                     end
        default    : begin                       // ä¸è·³è½?
                         o_branch_jalr <= 1'b0;
                         o_branch_jalr_target <= 0;
                     end
    endcase

always_comb
    casex({i_funct7,i_funct3,i_opcode})
        // JALç±»ä¸ŽJALRç±?
        17'bxxxxxxx_xxx_110x111 : o_res <=  i_pc + 4;             // JAL, JALR
        // LUIç±?
        17'bxxxxxxx_xxx_0110111 : o_res <=  i_immu;               // LUI
        // AUIPCç±?
        17'bxxxxxxx_xxx_0010111 : o_res <=  pc_plus_imm       ;   // AUIPC
        // ç®—æœ¯ç±?
        17'b0000000_000_0110011 : o_res <=  i_num1u +  i_num2u;   // ADD
        17'bxxxxxxx_000_0010011 : o_res <=  num1_plus_imm     ;   // ADDI
        17'b0100000_000_0110011 : o_res <=  i_num1u -  i_num2u;   // SUB
        // é€»è¾‘ç±?
        17'b0000000_100_0110011 : o_res <=  i_num1u ^  i_num2u;   // XOR
        17'bxxxxxxx_100_0010011 : o_res <=  i_num1u ^  i_immu ;   // XORI
        17'b0000000_110_0110011 : o_res <=  i_num1u |  i_num2u;   // OR
        17'bxxxxxxx_110_0010011 : o_res <=  i_num1u |  i_immu ;   // ORI
        17'b0000000_111_0110011 : o_res <=  i_num1u &  i_num2u;   // AND
        17'bxxxxxxx_111_0010011 : o_res <=  i_num1u &  i_immu ;   // ANDI
        // ä½ç§»ç±?
        17'b0000000_001_0110011 : o_res <=  i_num1u << shamt_rs ; // SLL
        17'b0000000_001_0010011 : o_res <=  i_num1u << shamt_imm; // SLLI
        17'b0000000_101_0110011 : o_res <=  i_num1u >> shamt_rs ; // SRL
        17'b0000000_101_0010011 : o_res <=  i_num1u >> shamt_imm; // SRL
        17'b0100000_101_0110011 : begin                           // SRA
                                      o_res <= i_num1u >> shamt_rs;
                                      for(int i=0;i< shamt_rs;i++) o_res[31-i] <= i_num1u[31];
                                  end
        17'b0100000_101_0010011 : begin                           // SRAI
                                      o_res <= i_num1u >> shamt_imm;
                                      for(int i=0;i<shamt_imm;i++) o_res[31-i] <= i_num1u[31];
                                  end
        // æ¯”è¾ƒç±?
        17'b0000000_010_0110011 : o_res <=  (i_num1s < i_num2s) ? 1 : 0;   // SLT
        17'bxxxxxxx_010_0010011 : o_res <=  (i_num1s < i_imms ) ? 1 : 0;   // SLTI
        17'b0000000_011_0110011 : o_res <=  (i_num1u < i_num2u) ? 1 : 0;   // SLTU
        17'bxxxxxxx_011_0010011 : o_res <=  (i_num1u < i_immu ) ? 1 : 0;   // SLTIU
        // æ— æ“ä½? 
        default   : o_res <= 0;
    endcase

endmodule
