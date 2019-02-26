module core_ex_branch_judge(
    input  logic i_branch,
    input  logic [31:0] i_num1u, i_num2u,
    input  logic [ 2:0] i_funct3,
    output logic o_branch
);

logic branch_judge_res;
assign o_branch = i_branch & branch_judge_res;

logic signed [31:0] i_num1s, i_num2s;
assign i_num1s = i_num1u;
assign i_num2s = i_num2u;

always_comb
    case(i_funct3)
        3'b000 : branch_judge_res <= (i_num1u == i_num2u);   // BEQ
        3'b001 : branch_judge_res <= (i_num1u != i_num2u);   // BNE
        3'b100 : branch_judge_res <= (i_num1s <  i_num2s);   // BLT
        3'b101 : branch_judge_res <= (i_num1s >= i_num2s);   // BGE
        3'b110 : branch_judge_res <= (i_num1u <  i_num2u);   // BLTU
        3'b111 : branch_judge_res <= (i_num1u >= i_num2u);   // BGEU
        default: branch_judge_res <= 1'b0;
    endcase

endmodule
