`timescale 1ns / 1ps

module top_level(rst,clk,data_in_x,data_in_y,data_in_z,
data_out_x1, data_out_y1, data_out_z1,data_out_x2, data_out_y2, data_out_z2,
data_out_x3, data_out_y3, data_out_z3,data_out_x4, data_out_y4, data_out_z4,
data_out_x5, data_out_y5, data_out_z5,data_out_x6, data_out_y6, data_out_z6,data_out_x7,
data_out_y7, data_out_z7,data_out_x8, data_out_y8, data_out_z8);

input rst,clk;
input signed [9:0] data_in_x,data_in_y,data_in_z;
output signed [16:0]data_out_x1, data_out_y1, data_out_z1,data_out_x2, data_out_y2, data_out_z2,
data_out_x3, data_out_y3, data_out_z3,data_out_x4, data_out_y4, data_out_z4,
data_out_x5, data_out_y5, data_out_z5,data_out_x6, data_out_y6, data_out_z6,data_out_x7,
data_out_y7, data_out_z7,data_out_x8, data_out_y8, data_out_z8;

wire [20:0]t31,t32,t33,t34,t35,t36,t37,t38,t39;
wire [20:0]MR1,MR2,MR3,MR5,MR6,MR9;
wire [20:0]t01,t02,t03,t05,t06,t09;
wire [20:0]t11,t12,t13,t14,t15,t16,t17,t18,t19;
wire [20:0]t21,t22,t23,t24,t25,t26,t27,t28,t29;

reg [3:0]state;
wire [3:0]state_wire;
wire [2:0]iteration_cnt;
wire [20:0]o1,o2,o3,o4,o5,o6,o7,o8,o9;

wire rst1;
wire cov_wire;
wire mux1_wire;
wire etme_wire;
wire [2:0]rotate_wire;

cov u0(.state(state_wire),.clk(clk),.rst(rst),.data_in_x(data_in_x),.data_in_y(data_in_y),
.data_in_z(data_in_z),.covXX(t01),.covXY(t02),.covXZ(t03),.covYY(t05),.covYZ(t06),.covZZ(t09),
.ctrl_cov(cov_wire));

mux1 u1(.state(state_wire),.clk(clk),.m1(t01),.m2(t02),.m3(t03),.m5(t05),.m6(t06)
,.m9(t09),.e1(MR1),.e2(MR2),.e3(MR3),.e5(MR5),.e6(MR6),.e9(MR9),.o1(t11),.o2(t12),
.o3(t13),.o5(t15),.o6(t16),.o9(t19),.iteration_cnt(iteration_cnt),
.ctrl_mux1(mux1_wire));

rotate u2(.state(state_wire),.clk(clk),.m1(t11),.m2(t12),.m3(t13),.m5(t15),.m6(t16),.m9(t19),
.o1(o1),.o2(o2),.o3(o3),.o4(o4),.o5(o5),.o6(o6),.o7(o7),.o8(o8),
.o9(o9),.ctrl_rotate(rotate_wire));

control u3 (.clk(clk), .ctrl_cov(cov_wire), .ctrl_mux1(mux1_wire), .ctrl_rotate(rotate_wire), 
.ctrl_etme(etme_wire),.rst(rst), .state(state_wire),.iteration_cnt(iteration_cnt));

ET_M_E u4 (.state(state_wire),.e1(o1), .e2(o2), .e3(o3), .e4(o4), .e5(o5), .e6(o6), .e7(o7), 
.e8(o8), .e9(o9),.m1(t11), .m2(t12), .m3(t13), .m4(t12), .m5(t15), .m6(t16), .m7(t13), .m8(t16), 
.m9(t19), .clk(clk), .MR1(MR1) , .MR2(MR2), .MR3(MR3), .MR5(MR5), .MR6(MR6),.MR9(MR9),
.ctrl_etme(etme_wire));

mux2 u5(.iteration_cnt(iteration_cnt),.state(state_wire),.clk(clk),.v1(t31),.v2(t32),.v3(t33),.v4(t34),
.v5(t35),.v6(t36),.v7(t37),.v8(t38),.v9(t39),.I1(t21),.I2(t22),.I3(t23),.I4(t24),.I5(t25),.I6(t26),
.I7(t27),.I8(t28),.I9(t29));

vector u6 (.state(state_wire),.a0(o1),.a1(o2),.a2(o3),
.a3(o4),.a4(o5),.a5(o6),.a6(o7),.a7(o8),.a8(o9),.b0(t21),.b1(t22),.b2(t23),.b3(t24),
.b4(t25),.b5(t26),.b6(t27),.b7(t28),.b8(t29),.clk(clk),.v0(t31),.v1(t32),.v2(t33),.v3(t34),
.v4(t35),.v5(t36),.v6(t37),.v7(t38),.v8(t39));

proj_obb u7 (.iteration_cnt(iteration_cnt),.rst(rst),.clk(clk),.data_in_x(data_in_x),.data_in_y(data_in_y),.data_in_z(data_in_z)
,.state(state_wire),.eigen_vector_x1(t31),.eigen_vector_y1(t32),.eigen_vector_z1(t33)
,.eigen_vector_x2(t34),.eigen_vector_y2(t35),.eigen_vector_z2(t36)
,.eigen_vector_x3(t37),.eigen_vector_y3(t38),.eigen_vector_z3(t39)
,.data_out_x1(data_out_x1), .data_out_y1(data_out_y1), .data_out_z1(data_out_z1), .data_out_x2(data_out_x2), .data_out_y2(data_out_y2), .data_out_z2(data_out_z2)
,.data_out_x3(data_out_x3), .data_out_y3(data_out_y3), .data_out_z3(data_out_z3), .data_out_x4(data_out_x4), .data_out_y4(data_out_y4), .data_out_z4(data_out_z4)
,.data_out_x5(data_out_x5), .data_out_y5(data_out_y5), .data_out_z5(data_out_z5), .data_out_x6(data_out_x6), .data_out_y6(data_out_y6), .data_out_z6(data_out_z6)
,.data_out_x7(data_out_x7), .data_out_y7(data_out_y7), .data_out_z7(data_out_z7), .data_out_x8(data_out_x8), .data_out_y8(data_out_y8), .data_out_z8(data_out_z8));


endmodule