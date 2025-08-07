`timescale 1ns / 1ps

module proj_obb(clk, rst, state, data_in_x, data_in_y, data_in_z, 
             eigen_vector_x1, eigen_vector_y1, eigen_vector_z1
            ,eigen_vector_x2, eigen_vector_y2, eigen_vector_z2
            ,eigen_vector_x3, eigen_vector_y3, eigen_vector_z3
            , data_out_x1, data_out_y1, data_out_z1, iteration_cnt
            , data_out_x2, data_out_y2, data_out_z2,
              data_out_x3, data_out_y3, data_out_z3,
              data_out_x4, data_out_y4, data_out_z4,
              data_out_x5, data_out_y5, data_out_z5,
              data_out_x6, data_out_y6, data_out_z6,
              data_out_x7, data_out_y7, data_out_z7,
              data_out_x8, data_out_y8, data_out_z8 );//TEST

input clk, rst;
input [3:0]state;
input signed [9:0]data_in_x, data_in_y, data_in_z;
input signed [20:0]eigen_vector_x1, eigen_vector_y1, eigen_vector_z1;
input signed [20:0]eigen_vector_x2, eigen_vector_y2, eigen_vector_z2;
input signed [20:0]eigen_vector_x3, eigen_vector_y3, eigen_vector_z3;
input [2:0]iteration_cnt;

output reg signed [16:0]data_out_x1, data_out_y1, data_out_z1;
output reg signed [16:0]data_out_x2, data_out_y2, data_out_z2;
output reg signed [16:0]data_out_x3, data_out_y3, data_out_z3;
output reg signed [16:0]data_out_x4, data_out_y4, data_out_z4;
output reg signed [16:0]data_out_x5, data_out_y5, data_out_z5;
output reg signed [16:0]data_out_x6, data_out_y6, data_out_z6;
output reg signed [16:0]data_out_x7, data_out_y7, data_out_z7;
output reg signed [16:0]data_out_x8, data_out_y8, data_out_z8;

reg signed [9:0] x_point[0:15];
reg signed [9:0] y_point[0:15];
reg signed [9:0] z_point[0:15];

reg signed [40:0] proj_new_axisX_x_point[0:15];
reg signed [40:0] proj_new_axisX_y_point[0:15];
reg signed [40:0] proj_new_axisX_z_point[0:15];

reg signed [40:0] proj_new_axisY_x_point[0:15];
reg signed [40:0] proj_new_axisY_y_point[0:15];
reg signed [40:0] proj_new_axisY_z_point[0:15];

reg signed [40:0] proj_new_axisZ_x_point[0:15];
reg signed [40:0] proj_new_axisZ_y_point[0:15];
reg signed [40:0] proj_new_axisZ_z_point[0:15];

reg [4:0] count_reg, count_proj_reg, count_max_reg, count, count_proj, count_max;

reg [4:0]max_count1, max_count2, max_count3;
reg [4:0]min_count1, min_count2, min_count3;
reg signed [40:0]max1, max2, max3;
reg signed [40:0]min1, min2, min3;
reg obb_center_en;

reg radias_en;

reg signed [40:0]obb_center[0:2];
reg signed [40:0]axis1_proj_center[0:2];
reg signed [40:0]axis2_proj_center[0:2];
reg signed [40:0]axis3_proj_center[0:2];

reg signed [40:0]radias1,radias2,radias3;
reg signed [40:0]radias1_out, radias2_out, radias3_out;
reg [3:0]sqrt_cnt_reg, sqrt_cnt;

always @(negedge clk) begin

    count <= count_reg;
    count_proj <= count_proj_reg;
    sqrt_cnt <= sqrt_cnt_reg;
    count_max <= count_max_reg;    

end 

always @(posedge clk) begin
    
    if(rst)begin
        count_reg <= 0;    
        count_proj_reg <= 0;
        count_max_reg <= 0;
        sqrt_cnt_reg <= 0;
    end
    
    else begin
    
    case(state)
        4'b0001: begin    
            if(count<16) begin
              x_point[count] <= data_in_x;
              y_point[count] <= data_in_y;
              z_point[count] <= data_in_z;
              count_reg <= count_reg + 1;
              obb_center_en <= 0;
              max_count1 <= 0;
              max_count2 <= 0;
              max_count3 <= 0;
              min_count1 <= 0;
              min_count2 <= 0;
              min_count3 <= 0;
              radias_en <= 0;
           end
        end
    
        default: begin
            if( (count_proj < 16)&&(iteration_cnt == 5 ) )begin
    
                proj_new_axisX_x_point[count_proj] <= ((x_point[count_proj]*eigen_vector_x1)+(y_point[count_proj]*eigen_vector_y1)
                +(z_point[count_proj]*eigen_vector_z1))*eigen_vector_x1;
                
                proj_new_axisX_y_point[count_proj] <= ((x_point[count_proj]*eigen_vector_x1)+(y_point[count_proj]*eigen_vector_y1)
                +(z_point[count_proj]*eigen_vector_z1))*eigen_vector_y1;
                
                proj_new_axisX_z_point[count_proj] <= ((x_point[count_proj]*eigen_vector_x1)+(y_point[count_proj]*eigen_vector_y1)
                +(z_point[count_proj]*eigen_vector_z1))*eigen_vector_z1;
                
                proj_new_axisY_x_point[count_proj] <= ((x_point[count_proj]*eigen_vector_x2)+(y_point[count_proj]*eigen_vector_y2)
                +(z_point[count_proj]*eigen_vector_z2))*eigen_vector_x2;
                
                proj_new_axisY_y_point[count_proj] <= ((x_point[count_proj]*eigen_vector_x2)+(y_point[count_proj]*eigen_vector_y2)
                +(z_point[count_proj]*eigen_vector_z2))*eigen_vector_y2;
                
                proj_new_axisY_z_point[count_proj] <= ((x_point[count_proj]*eigen_vector_x2)+(y_point[count_proj]*eigen_vector_y2)
                +(z_point[count_proj]*eigen_vector_z2))*eigen_vector_z2;
                
                proj_new_axisZ_x_point[count_proj] <= ((x_point[count_proj]*eigen_vector_x3)+(y_point[count_proj]*eigen_vector_y3)
                +(z_point[count_proj]*eigen_vector_z3))*eigen_vector_x3;
                
                proj_new_axisZ_y_point[count_proj] <= ((x_point[count_proj]*eigen_vector_x3)+(y_point[count_proj]*eigen_vector_y3)
                +(z_point[count_proj]*eigen_vector_z3))*eigen_vector_y3;
                
                proj_new_axisZ_z_point[count_proj] <= ((x_point[count_proj]*eigen_vector_x3)+(y_point[count_proj]*eigen_vector_y3)
                +(z_point[count_proj]*eigen_vector_z3))*eigen_vector_z3;
                
                count_proj_reg <= count_proj_reg + 1;
            end
          
            else begin            
                if((count_max < 16)&&(count_proj == 16))begin
                    if(count_max == 0)begin
                        max1 <= proj_new_axisX_x_point[0];
                        min1 <= proj_new_axisX_x_point[0];
                        
                        max2 <= proj_new_axisY_y_point[0];
                        min2 <= proj_new_axisY_y_point[0];
                              
                        max3 <= proj_new_axisZ_x_point[0];
                        min3 <= proj_new_axisZ_x_point[0];
                        
                        count_max_reg <= count_max_reg + 1;
                    end
                    else begin                  
                        if(proj_new_axisX_x_point[count_max] > max1)begin                        
                            max_count1 <= count_max;
                            max1 <= proj_new_axisX_x_point[count_max];
                        end
                        
                        if(proj_new_axisX_x_point[count_max] <= min1)begin                        
                            min_count1 <= count_max;
                            min1 <= proj_new_axisX_x_point[count_max];
                        end
                        
                        if(proj_new_axisY_y_point[count_max] > max2)begin                        
                            max_count2 <= count_max;
                            max2 <= proj_new_axisY_y_point[count_max];
                        end
                        
                        if(proj_new_axisY_y_point[count_max] <= min2)begin                        
                            min_count2 <= count_max;
                            min2 <= proj_new_axisY_y_point[count_max];
                        end
                        
                        if(proj_new_axisZ_x_point[count_max] > max3)begin                        
                            max_count3 <= count_max;
                            max3 <= proj_new_axisZ_x_point[count_max];
                        end
                        
                        if(proj_new_axisZ_x_point[count_max] <= min3)begin                        
                            min_count3 <= count_max;
                            min3 <= proj_new_axisZ_x_point[count_max];
                        end
                        count_max_reg <= count_max_reg + 1;
                    end                       
                end
                
                else if(count_max == 16)begin
                    
                    proj_new_axisX_x_point[max_count1] <= proj_new_axisX_x_point[max_count1] / ((eigen_vector_x1*eigen_vector_x1)+(eigen_vector_y1*eigen_vector_y1)+(eigen_vector_z1*eigen_vector_z1));
                    proj_new_axisX_x_point[min_count1] <= proj_new_axisX_x_point[min_count1] / ((eigen_vector_x1*eigen_vector_x1)+(eigen_vector_y1*eigen_vector_y1)+(eigen_vector_z1*eigen_vector_z1));  
                    proj_new_axisX_y_point[max_count1] <= proj_new_axisX_y_point[max_count1] / ((eigen_vector_x1*eigen_vector_x1)+(eigen_vector_y1*eigen_vector_y1)+(eigen_vector_z1*eigen_vector_z1));
                    proj_new_axisX_y_point[min_count1] <= proj_new_axisX_y_point[min_count1] / ((eigen_vector_x1*eigen_vector_x1)+(eigen_vector_y1*eigen_vector_y1)+(eigen_vector_z1*eigen_vector_z1));
                    proj_new_axisX_z_point[max_count1] <= proj_new_axisX_z_point[max_count1] / ((eigen_vector_x1*eigen_vector_x1)+(eigen_vector_y1*eigen_vector_y1)+(eigen_vector_z1*eigen_vector_z1));
                    proj_new_axisX_z_point[min_count1] <= proj_new_axisX_z_point[min_count1] / ((eigen_vector_x1*eigen_vector_x1)+(eigen_vector_y1*eigen_vector_y1)+(eigen_vector_z1*eigen_vector_z1));
                    
                    proj_new_axisY_x_point[max_count2] <= proj_new_axisY_x_point[max_count2] / ((eigen_vector_x2*eigen_vector_x2)+(eigen_vector_y2*eigen_vector_y2)+(eigen_vector_z2*eigen_vector_z2));
                    proj_new_axisY_x_point[min_count2] <= proj_new_axisY_x_point[min_count2] / ((eigen_vector_x2*eigen_vector_x2)+(eigen_vector_y2*eigen_vector_y2)+(eigen_vector_z2*eigen_vector_z2));  
                    proj_new_axisY_y_point[max_count2] <= proj_new_axisY_y_point[max_count2] / ((eigen_vector_x2*eigen_vector_x2)+(eigen_vector_y2*eigen_vector_y2)+(eigen_vector_z2*eigen_vector_z2));
                    proj_new_axisY_y_point[min_count2] <= proj_new_axisY_y_point[min_count2] / ((eigen_vector_x2*eigen_vector_x2)+(eigen_vector_y2*eigen_vector_y2)+(eigen_vector_z2*eigen_vector_z2));
                    proj_new_axisY_z_point[max_count2] <= proj_new_axisY_z_point[max_count2] / ((eigen_vector_x2*eigen_vector_x2)+(eigen_vector_y2*eigen_vector_y2)+(eigen_vector_z2*eigen_vector_z2));
                    proj_new_axisY_z_point[min_count2] <= proj_new_axisY_z_point[min_count2] / ((eigen_vector_x2*eigen_vector_x2)+(eigen_vector_y2*eigen_vector_y2)+(eigen_vector_z2*eigen_vector_z2));
                                                                                                                                                                                  
                    proj_new_axisZ_x_point[max_count3] <= proj_new_axisZ_x_point[max_count3] / ((eigen_vector_x3*eigen_vector_x3)+(eigen_vector_y3*eigen_vector_y3)+(eigen_vector_z3*eigen_vector_z3));
                    proj_new_axisZ_x_point[min_count3] <= proj_new_axisZ_x_point[min_count3] / ((eigen_vector_x3*eigen_vector_x3)+(eigen_vector_y3*eigen_vector_y3)+(eigen_vector_z3*eigen_vector_z3));  
                    proj_new_axisZ_y_point[max_count3] <= proj_new_axisZ_y_point[max_count3] / ((eigen_vector_x3*eigen_vector_x3)+(eigen_vector_y3*eigen_vector_y3)+(eigen_vector_z3*eigen_vector_z3));
                    proj_new_axisZ_y_point[min_count3] <= proj_new_axisZ_y_point[min_count3] / ((eigen_vector_x3*eigen_vector_x3)+(eigen_vector_y3*eigen_vector_y3)+(eigen_vector_z3*eigen_vector_z3));
                    proj_new_axisZ_z_point[max_count3] <= proj_new_axisZ_z_point[max_count3] / ((eigen_vector_x3*eigen_vector_x3)+(eigen_vector_y3*eigen_vector_y3)+(eigen_vector_z3*eigen_vector_z3));
                    proj_new_axisZ_z_point[min_count3] <= proj_new_axisZ_z_point[min_count3] / ((eigen_vector_x3*eigen_vector_x3)+(eigen_vector_y3*eigen_vector_y3)+(eigen_vector_z3*eigen_vector_z3));
                    count_max_reg <= count_max_reg + 1;                                                                                                                                             
                end
                
                else begin
                    if((count_max == 17) && (obb_center_en == 0))begin
                        axis1_proj_center[0] <= ((proj_new_axisX_x_point[max_count1] + proj_new_axisX_x_point[min_count1])/2);
                        axis1_proj_center[1] <= ((proj_new_axisX_y_point[max_count1] + proj_new_axisX_y_point[min_count1])/2);
                        axis1_proj_center[2] <= ((proj_new_axisX_z_point[max_count1] + proj_new_axisX_z_point[min_count1])/2);
                                                                                                                          
                        axis2_proj_center[0] <= ((proj_new_axisY_x_point[max_count2] + proj_new_axisY_x_point[min_count2])/2);
                        axis2_proj_center[1] <= ((proj_new_axisY_y_point[max_count2] + proj_new_axisY_y_point[min_count2])/2);
                        axis2_proj_center[2] <= ((proj_new_axisY_z_point[max_count2] + proj_new_axisY_z_point[min_count2])/2);
                                                                                                                          
                        axis3_proj_center[0] <= ((proj_new_axisZ_x_point[max_count3] + proj_new_axisZ_x_point[min_count3])/2);
                        axis3_proj_center[1] <= ((proj_new_axisZ_y_point[max_count3] + proj_new_axisZ_y_point[min_count3])/2);
                        axis3_proj_center[2] <= ((proj_new_axisZ_z_point[max_count3] + proj_new_axisZ_z_point[min_count3])/2);
                        obb_center_en <= 1;
                    end
                        
                    else if((obb_center_en) && (radias_en == 0))begin
                        obb_center[0] <= axis1_proj_center[0] + axis2_proj_center[0] + axis3_proj_center[0];     
                        obb_center[1] <= axis1_proj_center[1] + axis2_proj_center[1] + axis3_proj_center[1]; 
                        obb_center[2] <= axis1_proj_center[2] + axis2_proj_center[2] + axis3_proj_center[2];
                        radias_en <= 1;                   
                    end
                    
                    else if(radias_en)begin
                        if(sqrt_cnt < 11)begin
                            if(sqrt_cnt ==0)begin

                                radias1 <= (((axis1_proj_center[0]-proj_new_axisX_x_point[max_count1])
                                *(axis1_proj_center[0]-proj_new_axisX_x_point[max_count1]))+((axis1_proj_center[1]-proj_new_axisX_y_point[max_count1])
                                *(axis1_proj_center[1]-proj_new_axisX_y_point[max_count1]))+((axis1_proj_center[2]-proj_new_axisX_z_point[max_count1])
                                *(axis1_proj_center[2]-proj_new_axisX_z_point[max_count1])));
                                
                                radias2 <= ((axis2_proj_center[0]-proj_new_axisY_x_point[max_count2])
                                *(axis2_proj_center[0]-proj_new_axisY_x_point[max_count2])+(axis2_proj_center[1]-proj_new_axisY_y_point[max_count2])
                                *(axis2_proj_center[1]-proj_new_axisY_y_point[max_count2])+(axis2_proj_center[2]-proj_new_axisY_z_point[max_count2])
                                *(axis2_proj_center[2]-proj_new_axisY_z_point[max_count2]));
                                
                                radias3 <= ((axis3_proj_center[0]-proj_new_axisZ_x_point[max_count3])
                                *(axis3_proj_center[0]-proj_new_axisZ_x_point[max_count3])+(axis3_proj_center[1]-proj_new_axisZ_y_point[max_count3])
                                *(axis3_proj_center[1]-proj_new_axisZ_y_point[max_count3])+(axis3_proj_center[2]-proj_new_axisZ_z_point[max_count3])
                                *(axis3_proj_center[2]-proj_new_axisZ_z_point[max_count3]));                              
                                sqrt_cnt_reg <= sqrt_cnt_reg + 1;

                            end
                            else if(sqrt_cnt == 1)begin
                                radias1_out <= (radias1)/2;
                                radias2_out <= (radias2)/2;
                                radias3_out <= (radias3)/2;
                                sqrt_cnt_reg <= sqrt_cnt_reg + 1;
                            end
                            
                            else begin                                
                                radias1_out <= ((radias1_out + (radias1 / radias1_out))/2);
                                radias2_out <= ((radias2_out + (radias2 / radias2_out))/2);
                                radias3_out <= ((radias3_out + (radias3 / radias3_out))/2);
                                sqrt_cnt_reg <= sqrt_cnt_reg + 1;
                            end
                        end
                        
                        else begin

                            data_out_x1 <= (100*obb_center[0]) + ((radias1_out * eigen_vector_x1)) + ((radias2_out * eigen_vector_x2))+  ((radias3_out * eigen_vector_x3));
                            data_out_y1 <= (100*obb_center[1]) + ((radias1_out * eigen_vector_y1)) + ((radias2_out * eigen_vector_y2)) + ((radias3_out * eigen_vector_y3));
                            data_out_z1 <= (100*obb_center[2]) + ((radias1_out * eigen_vector_z1)) + ((radias2_out * eigen_vector_z2)) + ((radias3_out * eigen_vector_z3));
                                                                                                                                                      
                            data_out_x2 <= (100*obb_center[0]) + ((radias1_out * eigen_vector_x1)) + ((radias2_out * eigen_vector_x2)) - ((radias3_out * eigen_vector_x3));
                            data_out_y2 <= (100*obb_center[1]) + ((radias1_out * eigen_vector_y1)) + ((radias2_out * eigen_vector_y2)) - ((radias3_out * eigen_vector_y3));
                            data_out_z2 <= (100*obb_center[2]) + ((radias1_out * eigen_vector_z1)) + ((radias2_out * eigen_vector_z2)) - ((radias3_out * eigen_vector_z3)); 
                                                                                                                                                      
                            data_out_x3 <= (100*obb_center[0]) + ((radias1_out * eigen_vector_x1)) - ((radias2_out * eigen_vector_x2)) + ((radias3_out * eigen_vector_x3));
                            data_out_y3 <= (100*obb_center[1]) + ((radias1_out * eigen_vector_y1)) - ((radias2_out * eigen_vector_y2)) + ((radias3_out * eigen_vector_y3));
                            data_out_z3 <= (100*obb_center[2]) + ((radias1_out * eigen_vector_z1)) - ((radias2_out * eigen_vector_z2)) + ((radias3_out * eigen_vector_z3));
                                                                                                                                                      
                            data_out_x4 <= (100*obb_center[0]) + ((radias1_out * eigen_vector_x1)) - ((radias2_out * eigen_vector_x2)) - ((radias3_out * eigen_vector_x3));
                            data_out_y4 <= (100*obb_center[1]) + ((radias1_out * eigen_vector_y1)) - ((radias2_out * eigen_vector_y2)) - ((radias3_out * eigen_vector_y3));
                            data_out_z4 <= (100*obb_center[2]) + ((radias1_out * eigen_vector_z1)) - ((radias2_out * eigen_vector_z2)) - ((radias3_out * eigen_vector_z3));
                                                                                                                                                      
                            data_out_x5 <= (100*obb_center[0]) - ((radias1_out * eigen_vector_x1)) + ((radias2_out * eigen_vector_x2)) + ((radias3_out * eigen_vector_x3));
                            data_out_y5 <= (100*obb_center[1]) - ((radias1_out * eigen_vector_y1)) + ((radias2_out * eigen_vector_y2)) + ((radias3_out * eigen_vector_y3));
                            data_out_z5 <= (100*obb_center[2]) - ((radias1_out * eigen_vector_z1)) + ((radias2_out * eigen_vector_z2)) + ((radias3_out * eigen_vector_z3));
                                                                                                                                                    
                            data_out_x6 <= (100*obb_center[0]) - ((radias1_out * eigen_vector_x1)) + ((radias2_out * eigen_vector_x2)) - ((radias3_out * eigen_vector_x3));
                            data_out_y6 <= (100*obb_center[1]) - ((radias1_out * eigen_vector_y1)) + ((radias2_out * eigen_vector_y2)) - ((radias3_out * eigen_vector_y3));
                            data_out_z6 <= (100*obb_center[2]) - ((radias1_out * eigen_vector_z1)) + ((radias2_out * eigen_vector_z2)) - ((radias3_out * eigen_vector_z3));
                                                                                                                                                     
                            data_out_x7 <= (100*obb_center[0]) - ((radias1_out * eigen_vector_x1)) - ((radias2_out * eigen_vector_x2)) + ((radias3_out * eigen_vector_x3));
                            data_out_y7 <= (100*obb_center[1]) - ((radias1_out * eigen_vector_y1)) - ((radias2_out * eigen_vector_y2)) + ((radias3_out * eigen_vector_y3));
                            data_out_z7 <= (100*obb_center[2]) - ((radias1_out * eigen_vector_z1)) - ((radias2_out * eigen_vector_z2)) + ((radias3_out * eigen_vector_z3));
                                                                                                                           
                            data_out_x8 <= (100*obb_center[0]) - ((radias1_out * eigen_vector_x1)) - ((radias2_out * eigen_vector_x2)) - ((radias3_out * eigen_vector_x3));
                            data_out_y8 <= (100*obb_center[1]) - ((radias1_out * eigen_vector_y1)) - ((radias2_out * eigen_vector_y2)) - ((radias3_out * eigen_vector_y3));
                            data_out_z8 <= (100*obb_center[2]) - ((radias1_out * eigen_vector_z1)) - ((radias2_out * eigen_vector_z2)) - ((radias3_out * eigen_vector_z3));         

                        end                        
                    end
                end                        
            end         
      end
    endcase
    end
end
  
endmodule
