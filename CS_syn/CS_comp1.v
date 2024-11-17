`timescale 1ns/10ps
/*
 * IC Contest Computational System (CS)
*/
module CS(Y, X, reset, clk);

input clk, reset; 
input [7:0] X;
output [9:0] Y;

// Combinational signal
wire [7:0] X1, X2, X3, X4, X5, X6, X7, X8, X9;
wire [11:0] Sum_nxt, X1_9, X2_9, X3_9, X4_9, X5_9, X6_9, X7_9, X8_9, X9_9;
wire [11:0] After_Compare_to_Sum_X9_9;
wire [11:0] Compare_Reuslt_1, Compare_Reuslt_2, Compare_Reuslt_3, Compare_Reuslt_4, Compare_Reuslt_5, Compare_Reuslt_6, Compare_Reuslt_7;
wire [11:0] X_Appr_9;
wire Y_valid;

// Sequential reg
reg [11:0] Sum;
reg [7:0] X1_reg, X2_reg, X3_reg, X4_reg, X5_reg, X6_reg, X7_reg, X8_reg, X9_reg;

// Conect to reg
assign X1 = X1_reg;
assign X2 = X2_reg;
assign X3 = X3_reg;
assign X4 = X4_reg;
assign X5 = X5_reg;
assign X6 = X6_reg;
assign X7 = X7_reg;
assign X8 = X8_reg;
assign X9 = X9_reg;

// Combinational Block
assign Sum_nxt = Sum - X9 + X;
assign X1_9 = (X1<<3) + X1;
assign X2_9 = (X2<<3) + X2;
assign X3_9 = (X3<<3) + X3;
assign X4_9 = (X4<<3) + X4;
assign X5_9 = (X5<<3) + X5;
assign X6_9 = (X6<<3) + X6;
assign X7_9 = (X7<<3) + X7;
assign X8_9 = (X8<<3) + X8;
assign X9_9 = (X9<<3) + X9;
assign After_Compare_to_Sum_X9_9 = (Sum >= X9_9) ? X9_9 : 12'd0;

assign Compare_Reuslt_1 = (Sum >= X1_9) ? (Sum >= X2_9) ? (X1 >= X2) ? X1_9 : X2_9 : X1_9 :
                                        (Sum >= X2_9) ? X2_9 : 12'b0;
assign Compare_Reuslt_2 = (Sum >= X3_9) ? (Sum >= X4_9) ? (X3 >= X4) ? X3_9 : X4_9 : X3_9 :
                                        (Sum >= X4_9) ? X4_9 : 12'b0;
assign Compare_Reuslt_3 = (Sum >= X5_9) ? (Sum >= X6_9) ? (X5 >= X6) ? X5_9 : X6_9 : X5_9 :
                                        (Sum >= X6_9) ? X6_9 : 12'b0;
assign Compare_Reuslt_4 = (Sum >= X7_9) ? (Sum >= X8_9) ? (X7 >= X8) ? X7_9 : X8_9 : X7_9 :
                                        (Sum >= X8_9) ? X8_9 : 12'b0;

assign Compare_Reuslt_5 = (Compare_Reuslt_1 >= Compare_Reuslt_2) ? Compare_Reuslt_1 : Compare_Reuslt_2;
assign Compare_Reuslt_6 = (Compare_Reuslt_3 >= Compare_Reuslt_4) ? Compare_Reuslt_3 : Compare_Reuslt_4;

assign Compare_Reuslt_7 = (Compare_Reuslt_5 >= Compare_Reuslt_6) ? Compare_Reuslt_5 : Compare_Reuslt_6;
assign X_Appr_9 = (Compare_Reuslt_7 >= After_Compare_to_Sum_X9_9) ? Compare_Reuslt_7 : After_Compare_to_Sum_X9_9;

assign Y = (X_Appr_9 + Sum) >> 3;

// Sequential Block (FIFO)
always @(posedge clk) begin
    if (reset) begin
        Sum <= 0;
        X1_reg <= 0;
        X2_reg <= 0;
        X3_reg <= 0;
        X4_reg <= 0;
        X5_reg <= 0;
        X6_reg <= 0;
        X7_reg <= 0;
        X8_reg <= 0;
        X9_reg <= 0;
    end
    else begin
        Sum <= Sum_nxt;
        X1_reg <= X;
        X2_reg <= X1_reg;
        X3_reg <= X2_reg;
        X4_reg <= X3_reg;
        X5_reg <= X4_reg;
        X6_reg <= X5_reg;
        X7_reg <= X6_reg;
        X8_reg <= X7_reg;
        X9_reg <= X8_reg;
    end
    
end

 
endmodule
