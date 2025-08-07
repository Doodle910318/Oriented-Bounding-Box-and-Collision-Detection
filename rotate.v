`timescale 1ns / 1ps

module rotate(state,clk,m1,m2,m3,m5,m6,m9,o1,o2,o3,o4,o5,o6,o7,o8,o9
,ctrl_rotate);

input signed [20:0] m1,m2,m3,m5,m6,m9;
input clk;
input [3:0]state;
output reg [2:0]ctrl_rotate;
output reg signed [20:0]o1,o2,o3,o4,o5,o6,o7,o8,o9;
reg s;
reg signed [16:0]max,theta;
reg signed [16:0]k1,k2,k3;
reg signed [8:0]sin,cos;

always @(posedge clk)begin

     case(state) 
     
         4'b0001: begin   
             ctrl_rotate <= 0;
             s <= 0;
   
         end
         4'b0010: begin  
             ctrl_rotate <= 0;
             s <= 0;
           
         end    
         4'b1001: begin
            ctrl_rotate <= 0;
            s <= 0;
  
        end
         
         4'b0011: begin         
         ctrl_rotate <= 1;
         
             if(m2[16]==1) k1 <= ~m2 + 1;
             else k1 <= m2;
               
             if(m3[16]==1) k2 <= ~m3 + 1;
             else k2 <= m3;
             
             if(m6[16]==1) k3 <= ~m6 + 1;
             else k3 <= m6;
             
            end
       
        4'b0100: begin
        ctrl_rotate <= 2;
        
            if(k1>=k2 & k1>=k3) max <= k1;
            else if(k2>=k1 & k2>=k3) max <= k2;
            else if(k3>=k1 & k3>=k2) max <= k3;
       
        end
       
        //always@(max) begin
        4'b0101: begin
        ctrl_rotate <= 3;
        
            if(max == k1) begin
           
                theta <= (200*m2)/(m5 - m1);
                o3 <= 0;
                o6 <= 0;
                o7 <= 0;
                o8 <= 0;
                o9 <= 100;


       end
           
            else if(max == k2) begin
           
                theta <= (200*m3)/(m9 - m1);
                o2 <= 0;
                o4 <= 0;
                o6 <= 0;
                o8 <= 0;
                o5 <= 100;

            end
           
            else if(max == k3) begin
           
                theta <= (200*m6)/(m9 - m5);
                o2 <= 0;
                o3 <= 0;
                o4 <= 0;
                o7 <= 0;
                o1 <= 100;            

            end
        end
        
       4'b0110: begin
       ctrl_rotate <= 4;
       
       if(theta[16] == 1) begin
                theta <= ~theta + 1;
                s <= 1;
            end
        end    
        
        4'b0111: begin    
        ctrl_rotate <= 5;
            
            if(theta >4453)  cos <= 71;
            else if(theta > 1238) cos <= 73;
            else if(theta >  903) cos <= 74;
            else if(theta >  706) cos <= 75;
            else if(theta >  578) cos <= 76;
            else if(theta >  486) cos <= 77;
            else if(theta >  418) cos <= 78;
            else if(theta >  365) cos <= 79;
            else if(theta >  322) cos <= 80;
            else if(theta >  287) cos <= 81;
            else if(theta >  258) cos <= 82;
            else if(theta >  231) cos <= 83;
            else if(theta >  211) cos <= 84;
            else if(theta >  191) cos <= 85;
            else if(theta >  174) cos <= 86;
            else if(theta >  159) cos <= 87;
            else if(theta >  145) cos <= 88;
            else if(theta >  132) cos <= 89;
            else if(theta >  120) cos <= 90;
            else if(theta >  109) cos <= 91;
            else if(theta >   98) cos <= 92;
            else if(theta >   88) cos <= 93;
            else if(theta >   78) cos <= 94;
            else if(theta >   68) cos <= 95;
            else if(theta >   58) cos <= 96;
            else if(theta >   48) cos <= 97;
            else if(theta >   36) cos <= 98;
            else if(theta >   20) cos <= 99;
            else cos <= 100;
            
            if(theta >= 16806)  sin <= 71;
            else if(theta >= 2944) sin <= 70;
            else if(theta >= 1622) sin <= 69;
            else if(theta >= 1122) sin <= 68;
            else if(theta >=  860) sin <= 67;
            else if(theta >=  697) sin <= 66;
            else if(theta >=  587) sin <= 65;
            else if(theta >=  507) sin <= 64;
            else if(theta >=  446) sin <= 63;
            else if(theta >=  398) sin <= 62;
            else if(theta >=  360) sin <= 61;
            else if(theta >=  328) sin <= 60;
            else if(theta >=  301) sin <= 59;
            else if(theta >=  278) sin <= 58;
            else if(theta >=  258) sin <= 57;
            else if(theta >=  240) sin <= 56;
            else if(theta >=  225) sin <= 55;
            else if(theta >=  211) sin <= 54;
            else if(theta >=  199) sin <= 53;
            else if(theta >=  188) sin <= 52;
            else if(theta >=  178) sin <= 51;
            else if(theta >=  169) sin <= 50;
            else if(theta >=  160) sin <= 49;
            else if(theta >=  152) sin <= 48;
            else if(theta >=  145) sin <= 47;
            else if(theta >=  138) sin <= 46;
            else if(theta >=  132) sin <= 45;
            else if(theta >=  126) sin <= 44;
            else if(theta >=  120) sin <= 43;
            else if(theta >=  115) sin <= 42;
            else if(theta >=  110) sin <= 41;
            else if(theta >=  105) sin <= 40;
            else if(theta >=  101) sin <= 39;
            else if(theta >=   97) sin <= 38;
            else if(theta >=   93) sin <= 37;
            else if(theta >=   89) sin <= 36;
            else if(theta >=   85) sin <= 35;
            else if(theta >=   81) sin <= 34;
            else if(theta >=   78) sin <= 33;
            else if(theta >=   75) sin <= 32;
            else if(theta >=   71) sin <= 31;
            else if(theta >=   68) sin <= 30;
            else if(theta >=   65) sin <= 29;
            else if(theta >=   62) sin <= 28;
            else if(theta >=   59) sin <= 27;
            else if(theta >=   57) sin <= 26;
            else if(theta >=   54) sin <= 25;
            else if(theta >=   51) sin <= 24;
            else if(theta >=   49) sin <= 23;
            else if(theta >=   46) sin <= 22;
            else if(theta >=   44) sin <= 21;
            else if(theta >=   41) sin <= 20;
            else if(theta >=   39) sin <= 19;
            else if(theta >=   37) sin <= 18;
            else if(theta >=   34) sin <= 17;
            else if(theta >=   32) sin <= 16;
            else if(theta >=   30) sin <= 15;
            else if(theta >=   28) sin <= 14;
            else if(theta >=   26) sin <= 13;
            else if(theta >=   23) sin <= 12;
            else if(theta >=   21) sin <= 11;
            else if(theta >=   19) sin <= 10;
            else if(theta >=   17) sin <=  9;
            else if(theta >=   15) sin <=  8;
            else if(theta >=   13) sin <=  7;
            else if(theta >=   11) sin <=  6;
            else if(theta >=    9) sin <=  5;
            else if(theta >=    7) sin <=  4;
            else if(theta >=    5) sin <=  3;
            else if(theta >=    3) sin <=  2;
            else if(theta >=    1) sin <=  1;
            else sin <= 0;

      end
       
        4'b1000: begin
        ctrl_rotate <= 6;

                if(max == k1 & s == 0) begin
                    o1 <= cos;
                    o5 <= cos;
                    o2 <= sin;
                    o4 <= ~sin + 1;
                end
               
                else if(max == k1 & s == 1)begin
                    o1 <= cos;
                    o5 <= cos;
                    o2 <= ~sin + 1;
                    o4 <= sin;
                end
               
                else if(max == k2 & s == 0) begin

                        o1 <= cos;
                        o9 <= cos;
                        o3 <= sin;
                        o7 <= ~sin + 1;   
 
                end    
               
                else if(max == k2 & s == 1) begin

                        o1 <= cos;
                        o9 <= cos;
                        o3 <= ~sin + 1;
                        o7 <= sin;   
                          
                end
       
                else if(max == k3 & s == 0) begin

                        o5 <= cos;
                        o9 <= cos;
                        o6 <= sin;
                        o8 <= ~sin + 1;   
    
                end
           
                else if(max == k3 & s == 1) begin


                        o5 <= cos;
                        o9 <= cos;
                        o6 <= ~sin + 1;
                        o8 <= sin;   
 
                end   
         end
     endcase
end

endmodule

