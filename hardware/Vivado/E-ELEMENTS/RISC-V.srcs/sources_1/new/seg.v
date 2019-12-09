module seg(
            input clk,
            input [31:0] seg_data,
            output reg [7:0] DIG,
            output reg [7:0] SEL
    );

reg [18:0] cnt; 
reg [3:0] num;
reg clock_25m;
always@(posedge clk)
    begin
            clock_25m <= ~clock_25m;
    end

always@(posedge clock_25m)begin
    if(cnt == 19'b111_1111_1111_1111_1111)
        cnt <= 0;
    else 
        cnt <= cnt + 1;
end    

always@(posedge clock_25m)begin
    case(cnt[18:16]) 
    3'b000:
        begin SEL <= 8'b1111_1110; num <= seg_data[3:0]; end
    3'b001:                               
        begin SEL <= 8'b1111_1101; num <= seg_data[7:4]; end
    3'b010:                              
        begin SEL <= 8'b1111_1011; num <= seg_data[11:8]; end
    3'b011:                               
        begin SEL <= 8'b1111_0111; num <= seg_data[15:12]; end
    3'b100:                            
        begin SEL <= 8'b1110_1111; num <= seg_data[19:16]; end
    3'b101:                              
        begin SEL <= 8'b1101_1111; num <= seg_data[23:20]; end
    3'b110:                             
        begin SEL <= 8'b1011_1111; num <= seg_data[27:24]; end
    3'b111:                             
        begin SEL <= 8'b0111_1111; num <= seg_data[31:28]; end    
    endcase
end

always@(posedge clock_25m)begin
    case(num)
            4'h0	:	DIG	<=	8'b11000000; //0
            4'h1	:	DIG	<=	8'b11111001; //1
            4'h2	:	DIG	<=	8'b10100100; //2
            4'h3	:	DIG	<=	8'b10110000; //3
            4'h4	:	DIG	<=	8'b10011001; //4
            4'h5	:	DIG	<=	8'b10010010; //5
            4'h6	:	DIG	<=  8'b10000010; //6
            4'h7	:	DIG	<=	8'b11111000; //7
            4'h8	:	DIG	<=	8'b10000000; //8
            4'h9	:	DIG	<=	8'b10010000; //9
            4'hA	:	DIG	<=	8'b10001000; //a   
            4'hB	:	DIG	<=	8'b10000011; //b
            4'hC	:	DIG	<=	8'b11000110; //c
            4'hD	:	DIG	<=	8'b10100001; //d
            4'hE	:	DIG	<=	8'b10000110; //e
            4'hF	:	DIG	<=	8'b10001110; //f
            default  :  DIG <=  8'b11000000; //0
    endcase
end
  
endmodule
