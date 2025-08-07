`timescale 1ns / 1ps

module ET_M_E(state, e1, e2, e3, e4, e5, e6, e7, e8, e9, m1, m2, m3, m4, m5, m6, m7, m8
, m9, clk, MR1, MR2, MR3, MR5, MR6, MR9, ctrl_etme);

input signed [20:0] e1, e2, e3, e4, e5, e6, e7, e8, e9
, m1, m2, m3, m4, m5, m6, m7, m8 ,m9;

input [3:0]state;
input clk;
wire enable;

output signed [20:0]MR1,MR2,MR3,MR5,MR6,MR9;
output ctrl_etme;
wire signed [20:0]ET[0:8];
wire signed [20:0]ET_out[0:8];
//NO1:

assign ET[0] = e1; //e1
assign ET[1] = e4; //e2
assign ET[2] = e7; //e3
assign ET[3] = e2; //e4
assign ET[4] = e5; //e5
assign ET[5] = e8; //e6
assign ET[6] = e3; //e7
assign ET[7] = e6; //e8
assign ET[8] = e9; //e9

mat MAT1 (.state(state),.a0(ET[0]),.a1(ET[1]),.a2(ET[2]),.a3(ET[3]),.a4(ET[4]),.a5(ET[5]),.a6(ET[6])
,.a7(ET[7]),.a8(ET[8]),.b0(m1),.b1(m2),.b2(m3),.b3(m4),.b4(m5),.b5(m6),.b6(m7),.b7(m8)
,.b8(m9),.clk(clk),.m0(ET_out[0]),.m1(ET_out[1]),.m2(ET_out[2]),.m3(ET_out[3]),.m4(ET_out[4])
,.m5(ET_out[5]),.m6(ET_out[6]),.m7(ET_out[7]),.m8(ET_out[8]),.enable(enable));

mat2 MAT2 (.state(state),.a0(ET_out[0]),.a1(ET_out[1]),.a2(ET_out[2]),.a3(ET_out[3]),.a4(ET_out[4])
,.a5(ET_out[5]),.a6(ET_out[6]),.a7(ET_out[7]),.a8(ET_out[8]),.b0(e1),.b1(e2),.b2(e3),
.b3(e4),.b4(e5),.b5(e6),.b6(e7),.b7(e8),.b8(e9),.clk(clk),.m0(MR1),.m1(MR2),.m2(MR3),
.m4(MR5),.m5(MR6),.m8(MR9),.enable(enable),.ctrl_etme(ctrl_etme));



endmodule
