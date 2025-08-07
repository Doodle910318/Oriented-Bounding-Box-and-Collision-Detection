`timescale 1ns / 1ps

module collision(clk, rst, data_in_x, data_in_y, data_in_z, collision_detect, done_valid);

  input clk, rst;
  input signed [9:0]data_in_x, data_in_y, data_in_z;
  output reg collision_detect, done_valid;
  reg [3:0]state, state_next;
  reg [4:0]counter, input_cnt_reg;
  reg [4:0]separate_cnt, separate_cnt_reg;
  reg signed [9:0]crossx_A, crossx_B;
  reg signed [9:0]crossy_A, crossy_B;
  reg signed [9:0]crossz_A, crossz_B;
  reg signed [9:0]x_point[0:15];
  reg signed [9:0]y_point[0:15];
  reg signed [9:0]z_point[0:15];
  reg signed [18:0]separate;
  reg [4:0]max_min_cnt, max_min_cnt_reg;
  reg signed [27:0]max1, max2, min1, min2, max_all, min_all;
  reg signed [27:0]max1_reg, max2_reg, min1_reg, min2_reg, max_all_reg, min_all_reg;
  reg signed [27:0]proj1,proj2;
  reg [1:0]t;
  
always @(posedge clk) begin

    if(rst)begin
        state_next <= 0;
        input_cnt_reg <= 0;
        separate_cnt_reg <= 0;
        collision_detect <= 0;
        separate <= 0;
        max_min_cnt_reg <= 0;
        t <= 0;
        done_valid <= 0;
    end
    else begin
    case(state)

        4'b0000:begin
            if(counter < 16)begin
                x_point[counter] <= data_in_x;
                y_point[counter] <= data_in_y;
                z_point[counter] <= data_in_z;
                input_cnt_reg <= input_cnt_reg +1;
                state_next <= 4'b0000;
            end
            else begin
                state_next <= 4'b0001;
            end
        end
        
        4'b0001: begin //do point axis
            if(separate_cnt < 3)begin
                separate <= (x_point[separate_cnt +1] - x_point[0]);           
            end
            
            else if((separate_cnt < 6)&&(separate_cnt > 3)) begin
                separate <= (x_point[separate_cnt +6] - x_point[8]);
            end
            state_next <= 4'b0101;
        end
        
        4'b0010: begin //do cross product
            if(separate_cnt < 9)begin
                crossx_A <= x_point[1] - x_point[0];
                crossy_A <= y_point[1] - y_point[0];
                crossz_A <= z_point[1] - z_point[0];
                crossx_B <= x_point[separate_cnt +3] - x_point[8];
                crossy_B <= y_point[separate_cnt +3] - y_point[8];
                crossz_B <= z_point[separate_cnt +3] - z_point[8];
            end
                
            else if(separate_cnt < 12)begin
                crossx_A <= x_point[2] - x_point[0];
                crossy_A <= y_point[2] - y_point[0];
                crossz_A <= z_point[2] - z_point[0];
                crossx_B <= x_point[separate_cnt] - x_point[8];
                crossy_B <= y_point[separate_cnt] - y_point[8];
                crossz_B <= z_point[separate_cnt] - z_point[8];
            end
            
            else begin
                crossx_A <= x_point[3] - x_point[0];
                crossy_A <= y_point[3] - y_point[0];
                crossz_A <= z_point[3] - z_point[0];
                crossx_B <= x_point[separate_cnt -3] - x_point[8];
                crossy_B <= y_point[separate_cnt -3] - y_point[8];
                crossz_B <= z_point[separate_cnt -3] - z_point[8];
            end
            t <= 0;
            state_next <= 4'b0011;
        end
        
        4'b0011: begin
            case(t)
            0:begin
            	separate <= (crossy_A * crossz_B) - (crossy_B * crossz_A);
            	state_next <= 4'b0100;
            	end
            1:begin
                separate <= (crossz_A * crossx_B) - (crossz_B * crossx_A);
                state_next <= 4'b0100;
                end
            2:begin
		        separate <= (crossx_A * crossy_B) - (crossx_B * crossy_A);
		        state_next <= 4'b0100;
		        end
            3: begin
  		        state_next <= 4'b0010;
                separate_cnt_reg <= separate_cnt_reg + 1;
            end
            endcase
            
        end
        
        4'b0100: begin
           if(separate == 0) begin
               state_next <= 4'b0011;
               t <= t + 1;	  
           end
           else state_next <= 5+t;
        end
      
        4'b0101: begin
            if(max_min_cnt == 0)begin
                max1_reg <= separate * x_point[0];                    
                max2_reg <= separate * x_point[8];  
                min1_reg <= separate * x_point[0];
                min2_reg <= separate * x_point[8];
                max_all_reg <= separate * x_point[0];
                min_all_reg <= separate * x_point[0];
                max_min_cnt_reg <= max_min_cnt_reg +1;
            end
            else begin
                proj1 <= separate * x_point[max_min_cnt];
                proj2 <= separate * x_point[max_min_cnt +8];  
                state_next <= 4'b1000;                       
            end
        end
            
	    4'b0110: begin
            if(max_min_cnt == 0)begin
                max1_reg <= separate * y_point[0];                    
                max2_reg <= separate * y_point[8];  
                min1_reg <= separate * y_point[0];
                min2_reg <= separate * y_point[8];
                max_all_reg <= separate * y_point[0];
                min_all_reg <= separate * y_point[0];
                max_min_cnt_reg <= max_min_cnt_reg +1;
            end
            else begin
                proj1 <= separate * y_point[max_min_cnt];
                proj2 <= separate * y_point[max_min_cnt +8];  
                state_next <= 4'b1000;                       
            end
        end

	    4'b0111: begin
            if(max_min_cnt == 0)begin
                max1_reg <= separate * z_point[0];                    
                max2_reg <= separate * z_point[8];  
                min1_reg <= separate * z_point[0];
                min2_reg <= separate * z_point[8];
                max_all_reg <= separate * z_point[0];
                min_all_reg <= separate * z_point[0];
                max_min_cnt_reg <= max_min_cnt_reg +1;
            end
            else begin
                proj1 <= separate * z_point[max_min_cnt];
                proj2 <= separate * z_point[max_min_cnt +8];  
                state_next <= 4'b1000;                       
            end
        end
               
        4'b1000: begin
            if(max_min_cnt < 8)begin
                if(proj1 > max1) max1_reg <= proj1;
                if(proj1 < min1) min1_reg <= proj1;
                if(proj2 > max2) max2_reg <= proj2;
                if(proj2 < min2) min2_reg <= proj2;
                if((proj1 > max_all)&&(proj1 > proj2))  max_all_reg <= proj1;                  
                else if((proj2 > max_all)&&(proj2 > proj1))  max_all_reg <= proj2;
                if((proj1 < min_all)&&(proj1 < proj2))  min_all_reg <= proj1;
                else if((proj2 < min_all)&&(proj2 < proj1))  min_all_reg <= proj2;
                max_min_cnt_reg <= max_min_cnt_reg +1;     
            end
            else begin
                if((max1_reg + max2_reg - min1_reg - min2_reg) < (max_all_reg - min_all_reg))begin
                   state_next <= 4'b1010;
                end
                else state_next <= 4'b1001;
                separate_cnt_reg <= separate_cnt_reg +1;
                max_min_cnt_reg <= 0;
            end                                              
        end

        4'b1001: begin
            if((done_valid == 0)&&(separate_cnt < 6))begin
                state_next <= 4'b0001;
            end
            else if((done_valid == 0)&&(separate_cnt >= 6)&&(separate_cnt < 15)) begin
                state_next <= 4'b0010;
            end
            else begin
                state_next <= 4'b1011;
            end  
        end
        4'b1010: begin
            done_valid <= 1;
            collision_detect <= 0;
            state_next <= 4'b1100;
        end
        4'b1011: begin
            done_valid <= 1;
            collision_detect <= 1;
            state_next <= 4'b1100;
        end      
        default: begin
            done_valid <= 0;
            collision_detect <= 0;
            state_next <= 4'b1100;
            end
    endcase   
end
end
always @(negedge clk) begin
    counter <= input_cnt_reg;
    separate_cnt <= separate_cnt_reg;
    max_min_cnt <= max_min_cnt_reg;
    state <= state_next;
    max1 <= max1_reg;
    max2 <= max2_reg;
    min1 <= min1_reg;
    min2 <= min2_reg;
    max_all <= max_all_reg;
    min_all <= max_all_reg;    
end

endmodule
