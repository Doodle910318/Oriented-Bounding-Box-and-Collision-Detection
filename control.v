`timescale 1ns / 1ps

module control (clk, rst, state, iteration_cnt, ctrl_cov, ctrl_mux1, ctrl_rotate,
ctrl_etme);//TEST

input rst,clk;
input ctrl_cov;
input ctrl_mux1;
input ctrl_etme;
input [2:0]ctrl_rotate;

output [3:0]state;
output [2:0]iteration_cnt;

reg [3:0]state_reg;
reg [2:0]iteration_cnt_reg;
reg cnt_reg;
parameter state_cov = 4'b0001, state_mux = 4'b0010, state_rotate = 4'b0011, state_k = 4'b0100, state_max = 4'b0101, 
state_theta = 4'b0110, state_s = 4'b0111, state_counter = 4'b1000, state_ET_M_E = 4'b1001;

assign state = state_reg;
assign iteration_cnt = iteration_cnt_reg;


always@(posedge clk) begin

    if(rst)begin
        state_reg <= 1;
        iteration_cnt_reg <= 0 ;
    end
    
    else if(iteration_cnt_reg==5) state_reg <= 0;
    
    
    else if(ctrl_cov | ctrl_etme) begin
        if(ctrl_etme) iteration_cnt_reg <=  iteration_cnt_reg + 1;
        
        state_reg  <= 2;
    end 
    
    else if(ctrl_mux1) begin
        state_reg <= 3;
    end
    
    else if(ctrl_rotate == 1) begin
        state_reg <= 4;
    end
    
    else if(ctrl_rotate == 2) begin
        state_reg <= 5;
    end    
    
    else if(ctrl_rotate == 3) begin
        state_reg <= 6;
    end    
    
    else if(ctrl_rotate == 4) begin
        state_reg <= 7;
    end
    
    else if(ctrl_rotate == 5) begin
        state_reg <= 8;
    end
    
    else if(ctrl_rotate == 6) begin
        state_reg <= 9;
    end
end

endmodule