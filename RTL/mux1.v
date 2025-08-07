`timescale 1ns / 1ps

        module mux1(iteration_cnt, state, clk ,m1 ,m2 ,m3, m5, m6, m9,
e1, e2, e3, e5, e6, e9, o1, o2, o3, o5, o6, o9, ctrl_mux1);

input [3:0]state;
input clk;
input [2:0]iteration_cnt;
input signed [20:0] m1,m2,m3,m5,m6,m9;
input signed [20:0] e1,e2,e3,e5,e6,e9;
output reg signed [20:0]o1,o2,o3,o5,o6,o9;
output reg ctrl_mux1;

always @(posedge clk) begin

    case(state)
    4'b0000: ctrl_mux1 <= 0;
    4'b0001: ctrl_mux1 <= 0;
    4'b0011: ctrl_mux1 <= 0;
    
    4'b0010: begin
    ctrl_mux1 <= 1;
    
        if(iteration_cnt==0)begin
            o1 <= m1;
            o2 <= m2;
            o3 <= m3;
            o5 <= m5;
            o6 <= m6;
            o9 <= m9;
        end
        else begin
            o1 <= e1;
            o2 <= e2;
            o3 <= e3;
            o5 <= e5;
            o6 <= e6;
            o9 <= e9;
        end
    end
    endcase
end


endmodule
