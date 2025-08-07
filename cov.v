`timescale 1ns / 1ps

module cov (state,clk, rst, data_in_x, data_in_y, data_in_z, covXX,covXY,covXZ,covYY,covYZ,covZZ,ctrl_cov);

  input clk, rst;
  input signed [9:0]data_in_x, data_in_y, data_in_z;
  input [3:0] state;
  output reg ctrl_cov;
  output reg signed [20:0]covXX,covXY,covXZ,covYY,covYZ,covZZ;
  
  reg signed [20:0] x_point[0:15];
  reg signed [20:0] y_point[0:15];
  reg signed [20:0] z_point[0:15];
  reg signed [20:0] sum_x;
  reg signed [20:0] sum_y;
  reg signed [20:0] sum_z;
  reg [4:0] count;
  reg [4:0] count_reg;
  reg [5:0] count_cov;
  reg [5:0] count_cov_reg;
  reg signed [20:0] mean_x;
  reg signed [20:0] mean_y;
  reg signed [20:0] mean_z;

always @(negedge clk) begin

    count <= count_reg;
    count_cov <= count_cov_reg;
end 

always @(posedge clk) begin

  case(state)  
      4'b0010: ctrl_cov <= 0;
      4'b0001: begin
      if (rst) begin
          sum_x <= 0;
          sum_y <= 0;
          sum_z <= 0;
          count <= 0;
          count_reg <= 0;
          ctrl_cov <= 0;
          count_cov <= 0;
          count_cov_reg <= 0;
          mean_x <= 0;
          mean_y <= 0;
          mean_z <= 0;
          covXX <= 0;
          covXY <= 0;
          covXZ <= 0;
          covYY <= 0;
          covYZ <= 0;
          covZZ <= 0;
      end     
      
      else if(count <16) begin
          sum_x <= sum_x + data_in_x;
          sum_y <= sum_y + data_in_y;
          sum_z <= sum_z + data_in_z;
          x_point[count] <= data_in_x;
          y_point[count] <= data_in_y;
          z_point[count] <= data_in_z;
          count_reg <= count_reg + 1;
          mean_x <= sum_x >>> 4;
          mean_y <= sum_y >>> 4;
          mean_z <= sum_z >>> 4;
      end
     
      else if(count_cov < 17) begin
          if(count_cov < 16) begin
              covXX <= covXX + ((x_point[count_cov] - mean_x)*(x_point[count_cov] - mean_x));
              covXY <= covXY + ((x_point[count_cov] - mean_x)*(y_point[count_cov] - mean_y));
              covXZ <= covXZ + ((x_point[count_cov] - mean_x)*(z_point[count_cov] - mean_z));
              covYY <= covYY + ((y_point[count_cov] - mean_y)*(y_point[count_cov] - mean_y));
              covYZ <= covYZ + ((y_point[count_cov] - mean_y)*(z_point[count_cov] - mean_z));
              covZZ <= covZZ + ((z_point[count_cov] - mean_z)*(z_point[count_cov] - mean_z));
              count_cov_reg <= count_cov_reg + 1;
          end
          else begin
              covXX <= covXX >>> 4;
              covXY <= covXY >>> 4;
              covXZ <= covXZ >>> 4;
              covYY <= covYY >>> 4;
              covYZ <= covYZ >>> 4;
              covZZ <= covZZ >>> 4;
              count_cov_reg <= count_cov_reg + 1;
              ctrl_cov <= 1;
          end
      end
    end
        
    endcase
end

endmodule
