`timescale 1ns/10ps
/*
 * IC Contest Computational System (CS)
*/
module CS(Y, X, reset, clk);

input clk, reset; 
input [7:0] X;
output reg [9:0] Y;

// Combinational signal
wire [7:0] X1, X2, X3, X4, X5, X6, X7, X8, X9;
wire [7:0] avg;
wire [11:0] Sum_mid;

wire [7:0] After_Compare_to_Sum_X1_9;
wire [7:0] Compare_Reuslt_1, Compare_Reuslt_2, Compare_Reuslt_3, Compare_Reuslt_4, Compare_Reuslt_5, Compare_Reuslt_6, Compare_Reuslt_7;
wire [7:0] X_Appr;
wire [9:0] Y_;

// Sequential reg
reg  [11:0] Sum;
reg  [11:0] Sum_nxt;
reg  [7:0] X1_reg, X2_reg, X3_reg, X4_reg, X5_reg, X6_reg, X7_reg, X8_reg, X9_reg, X10_reg;

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
assign Sum_mid = Sum - X10_reg + X;
assign avg = Sum_mid / 9;

assign After_Compare_to_Sum_X1_9 = (avg >= X1) ? X1 : 8'd0;

assign Compare_Reuslt_1 = (avg >= X9) ? (avg >= X2) ? (X9 >= X2) ? X9 : X2 : X9 :
                                        (avg >= X2) ? X2 : 8'd0;
assign Compare_Reuslt_2 = (avg >= X3) ? (avg >= X4) ? (X3 >= X4) ? X3 : X4 : X3 :
                                        (avg >= X4) ? X4 : 8'd0;
assign Compare_Reuslt_3 = (avg >= X5) ? (avg >= X6) ? (X5 >= X6) ? X5 : X6 : X5 :
                                        (avg >= X6) ? X6 : 8'd0;
assign Compare_Reuslt_4 = (avg >= X7) ? (avg >= X8) ? (X7 >= X8) ? X7 : X8 : X7 :
                                        (avg >= X8) ? X8 : 8'd0;

assign Compare_Reuslt_5 = (Compare_Reuslt_1 >= Compare_Reuslt_2) ? Compare_Reuslt_1 : Compare_Reuslt_2;
assign Compare_Reuslt_6 = (Compare_Reuslt_3 >= Compare_Reuslt_4) ? Compare_Reuslt_3 : Compare_Reuslt_4;

assign Compare_Reuslt_7 = (Compare_Reuslt_5 >= Compare_Reuslt_6) ? Compare_Reuslt_5 : Compare_Reuslt_6;
assign X_Appr = (Compare_Reuslt_7 >= After_Compare_to_Sum_X1_9) ? Compare_Reuslt_7 : After_Compare_to_Sum_X1_9;
assign Y_ = ((X_Appr << 3) + X_Appr + Sum_mid) >> 3;

// Sequential Block (FIFO) But X1 is Posedge
always @(posedge clk) begin
    if (reset) begin
        X1_reg <= 0;
        Sum_nxt <= 0;
    end
    else begin
        X1_reg <= X;
        Sum_nxt <= Sum_mid;
    end
end
always @(negedge clk) begin
    if (reset) begin
        Y <= 0;
        Sum <= 0;
        X2_reg <= 0;
        X3_reg <= 0;
        X4_reg <= 0;
        X5_reg <= 0;
        X6_reg <= 0;
        X7_reg <= 0;
        X8_reg <= 0;
        X9_reg <= 0;
        X10_reg <= 0;
    end
    else begin
        Y <= Y_;
        Sum <= Sum_nxt;
        X2_reg <= X1_reg;
        X3_reg <= X2_reg;
        X4_reg <= X3_reg;
        X5_reg <= X4_reg;
        X6_reg <= X5_reg;
        X7_reg <= X6_reg;
        X8_reg <= X7_reg;
        X9_reg <= X8_reg;
        X10_reg <= X9_reg;
    end
end

endmodule