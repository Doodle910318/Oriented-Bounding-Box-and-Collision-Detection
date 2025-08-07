`timescale 1ns / 1ps

module tb_top;

  reg clk;
  reg rst;
  reg [9:0] data_in_x;
  reg [9:0] data_in_y;
  reg [9:0] data_in_z;
  wire [16:0] data_out_x1, data_out_y1, data_out_z1,data_out_x2, data_out_y2, data_out_z2,
data_out_x3, data_out_y3, data_out_z3,data_out_x4, data_out_y4, data_out_z4,
data_out_x5, data_out_y5, data_out_z5,data_out_x6, data_out_y6, data_out_z6,data_out_x7,
data_out_y7, data_out_z7,data_out_x8, data_out_y8, data_out_z8;

  top_level uut (
           .rst(rst)
    ,      .clk(clk)
    ,.data_in_x(data_in_x)
    ,.data_in_y(data_in_y)
    ,.data_in_z(data_in_z)
    ,.data_out_x1(data_out_x1), .data_out_y1(data_out_y1), .data_out_z1(data_out_z1), .data_out_x2(data_out_x2), .data_out_y2(data_out_y2), .data_out_z2(data_out_z2)
    ,.data_out_x3(data_out_x3), .data_out_y3(data_out_y3), .data_out_z3(data_out_z3), .data_out_x4(data_out_x4), .data_out_y4(data_out_y4), .data_out_z4(data_out_z4)
    ,.data_out_x5(data_out_x5), .data_out_y5(data_out_y5), .data_out_z5(data_out_z5), .data_out_x6(data_out_x6), .data_out_y6(data_out_y6), .data_out_z6(data_out_z6)
    ,.data_out_x7(data_out_x7), .data_out_y7(data_out_y7), .data_out_z7(data_out_z7), .data_out_x8(data_out_x8), .data_out_y8(data_out_y8), .data_out_z8(data_out_z8));

  
initial begin
    clk = 0;
    rst = 1;
    #50 rst = 0;
    data_in_x = 216;
    data_in_y = 80;
    data_in_z = -98;    

    #10 data_in_x = 25;
    data_in_y = 67;
    data_in_z = 62;
   
    #10 data_in_x = -70;
    data_in_y = 133;
    data_in_z = 300;
   
    #10 data_in_x = 64;
    data_in_y = 28;
    data_in_z = 0;

    #10 data_in_x = 94;
    data_in_y = 222;
    data_in_z = -80;
   
    #10 data_in_x = 58;
    data_in_y = 19;
    data_in_z = 72;
   
    #10 data_in_x = -49;
    data_in_y = -18;
    data_in_z = -28;
   
    #10 data_in_x = -365;
    data_in_y = -77;
    data_in_z = -28;
   
    #10 data_in_x = 18;
    data_in_y = -29;
    data_in_z = -17;
   
    #10 data_in_x = -192;
    data_in_y = 197;
    data_in_z = 284;
   
    #10 data_in_x = -348;
    data_in_y = 297;
    data_in_z = 25;
   
    #10 data_in_x = 138;
    data_in_y = -197;
    data_in_z = 91;
   
    #10 data_in_x = 84;
    data_in_y = 38;
    data_in_z = -9;
   
    #10 data_in_x = 19;
    data_in_y = -87;
    data_in_z = 87;
   
    #10 data_in_x = 197;
    data_in_y = -289;
    data_in_z = 19;
   
    #10 data_in_x = 269;
    data_in_y = -48;
    data_in_z = 59;
    #2500 $finish;

  end

  always #5 clk = ~clk;
 

endmodule

