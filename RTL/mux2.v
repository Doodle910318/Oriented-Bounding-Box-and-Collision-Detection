`timescale 1ns / 1ps

module mux2(iteration_cnt, state, clk , v1, v2, v3, v4, v5, v6, v7,
v8, v9, I1, I2, I3, I4, I5, I6, I7, I8, I9);

input [3:0]state;
input clk;
input [2:0]iteration_cnt;
input signed [20:0] v1,v2,v3,v4,v5,v6,v7,v8,v9;
output reg signed [20:0]I1,I2,I3,I4,I5,I6,I7,I8,I9;

always @(posedge clk) begin

    case(state)

    4'b1001: begin
    
        if(iteration_cnt==0)begin
            I1 <= 100;
            I2 <= 0;
            I3 <= 0;
            I4 <= 0;
            I5 <= 100;
            I6 <= 0;
            I7 <= 0;
            I8 <= 0;
            I9 <= 100;
        end
        else begin
            I1 <= v1;
            I2 <= v2;
            I3 <= v3;
            I4 <= v4;
            I5 <= v5;
            I6 <= v6;
            I7 <= v7;
            I8 <= v8;
            I9 <= v9;
        end
    end
    endcase
end


endmodule
