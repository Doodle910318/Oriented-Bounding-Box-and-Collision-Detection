`timescale 1ns / 1ps


module mat(state,clk,a0,a1,a2,a3,a4,a5,a6,a7,a8,
b0,b1,b2,b3,b4,b5,b6,b7,b8,m0,m1,m2,m3,m4,m5,m6,m7,m8,enable);

input signed [20:0]a0,a1,a2,a3,a4,a5,a6,a7,a8;
input signed [20:0]b0,b1,b2,b3,b4,b5,b6,b7,b8;
input [3:0]state;
input clk;

reg signed [40:0]sum[0:8];
            
reg signed [40:0]ac1[0:2];
reg signed [40:0]bc1[0:3];
reg signed [40:0]cc1[0:4];
reg signed [40:0]ac2[0:2];
reg signed [40:0]bc2[0:3];
reg signed [40:0]cc2[0:4];

reg [3:0]cnt1;
 
reg signed [40:0]k0[0:1];
reg signed [40:0]k1[0:1];
reg signed [40:0]k2[0:1];
reg signed [40:0]k3[0:1];
reg signed [40:0]k4[0:1];
reg signed [40:0]k5[0:1];
reg signed [40:0]k6[0:1];
reg signed [40:0]k7[0:1];
reg signed [40:0]k8[0:1];

output reg enable;

output reg signed [20:0]m0;
output reg signed [20:0]m1;
output reg signed [20:0]m2;
output reg signed [20:0]m3;
output reg signed [20:0]m4;
output reg signed [20:0]m5;
output reg signed [20:0]m6;
output reg signed [20:0]m7;
output reg signed [20:0]m8;

always@(posedge clk ) begin

    case(state)
     4'b0010: begin
            enable <= 0;
            k0[0] <= 0;
            k1[0] <= 0;
            k2[0] <= 0;
            k3[0] <= 0;
            k4[0] <= 0;
            k5[0] <= 0;
            k6[0] <= 0;
            k7[0] <= 0;
            k8[0] <= 0;
            
            k0[1] <= 0;
            k1[1] <= 0;
            k2[1] <= 0;
            k3[1] <= 0;
            k4[1] <= 0;
            k5[1] <= 0;
            k6[1] <= 0;
            k7[1] <= 0;
            k8[1] <= 0;
            
            cnt1 <= 0;
             
            sum[0] <= 0;
            sum[1] <= 0;
            sum[2] <= 0;
            sum[3] <= 0;
            sum[4] <= 0;
            sum[5] <= 0;
            sum[6] <= 0;
            sum[7] <= 0;
            sum[8] <= 0;
            
            ac1[0] <= 0;
            ac1[1] <= 0;
            ac1[2] <= 0;
                      
            bc1[0] <= 0;
            bc1[1] <= 0;
            bc1[2] <= 0;
            bc1[3] <= 0;
                      
            cc1[0] <= 0;
            cc1[1] <= 0;
            cc1[2] <= 0;
            cc1[3] <= 0;
            cc1[4] <= 0;
                      
                      
            ac2[0] <= 0;
            ac2[1] <= 0;
            ac2[2] <= 0;
                      
            bc2[0] <= 0;
            bc2[1] <= 0;
            bc2[2] <= 0;
            bc2[3] <= 0;
                      
            cc2[0] <= 0;
            cc2[1] <= 0;
            cc2[2] <= 0;
            cc2[3] <= 0;
            cc2[4] <= 0;
        end
        
    4'b1001: begin
    if(cnt1 == 0) begin   
    
            k0[0] <= 0;
            k1[0] <= 0;
            k2[0] <= 0;
            k3[0] <= 0;
            k4[0] <= 0;
            k5[0] <= 0;
            k6[0] <= 0;
            k7[0] <= 0;
            k8[0] <= 0;
            
            k0[1] <= 0;
            k1[1] <= 0;
            k2[1] <= 0;
            k3[1] <= 0;
            k4[1] <= 0;
            k5[1] <= 0;
            k6[1] <= 0;
            k7[1] <= 0;
            k8[1] <= 0;
            
            cnt1 <= 1;
             
            sum[0] <= 0;
            sum[1] <= 0;
            sum[2] <= 0;
            sum[3] <= 0;
            sum[4] <= 0;
            sum[5] <= 0;
            sum[6] <= 0;
            sum[7] <= 0;
            sum[8] <= 0;
            
            ac1[0] <= { {20{a0[20]}},a0 };
            ac1[1] <= { {20{a1[20]}},a1 };
            ac1[2] <= { {20{a2[20]}},a2 };
            
            bc1[0] <= 0;
            bc1[1] <= { {20{a3[20]}},a3 };
            bc1[2] <= { {20{a4[20]}},a4 };
            bc1[3] <= { {20{a5[20]}},a5 };
            
            cc1[0] <= 0;
            cc1[1] <= 0;
            cc1[2] <= { {20{a6[20]}},a6 };
            cc1[3] <= { {20{a7[20]}},a7 };
            cc1[4] <= { {20{a8[20]}},a8 };
            
            ac2[0] <= { {20{b0[20]}},b0 };
            ac2[1] <= { {20{b3[20]}},b3 };
            ac2[2] <= { {20{b6[20]}},b6 };
            
            bc2[0] <= 0;
            bc2[1] <= { {20{b1[20]}},b1 };
            bc2[2] <= { {20{b4[20]}},b4 };
            bc2[3] <= { {20{b7[20]}},b7 };
            
            cc2[0] <= 0;
            cc2[1] <= 0;
            cc2[2] <= { {20{b2[20]}},b2 };
            cc2[3] <= { {20{b5[20]}},b5 };
            cc2[4] <= { {20{b8[20]}},b8 };
        end
        
        else if (cnt1==4'b1001) begin
        
             enable <= 1;
             m0 <= sum[0];
             m1 <= sum[1];
             m2 <= sum[2];
             m3 <= sum[3];
             m4 <= sum[4];
             m5 <= sum[5];
             m6 <= sum[6];
             m7 <= sum[7];
             m8 <= sum[8];
             
        end
        
        else begin
        
            cnt1 <= cnt1 + 1;
            
            cc1[4] <= 0;
            cc1[3] <= cc1[4];
            cc1[2] <= cc1[3];
            cc1[1] <= cc1[2];
            cc1[0] <= cc1[1];
            k6[0]  <= cc1[0];
            k7[0]  <= k6[0];
            k8[0]  <= k7[0];
            
            cc2[4] <= 0;
            cc2[3] <= cc2[4];
            cc2[2] <= cc2[3];
            cc2[1] <= cc2[2];
            cc2[0] <= cc2[1];
            k2[1]  <= cc2[0];
            k5[1]  <= k2[1];
            k8[1]  <= k5[1];
            
            bc1[3] <= 0;
            bc1[2] <= bc1[3];
            bc1[1] <= bc1[2];
            bc1[0] <= bc1[1];
            k3[0]  <= bc1[0];
            k4[0]  <= k3[0];
            k5[0]  <= k4[0];
            
            bc2[3] <= 0;
            bc2[2] <= bc2[3];
            bc2[1] <= bc2[2];
            bc2[0] <= bc2[1];
            k1[1]  <= bc2[0];
            k4[1]  <= k1[1];
            k7[1]  <= k4[1];
            
            ac1[2] <= 0;
            ac1[1] <= ac1[2];
            ac1[0] <= ac1[1];
            k0[0]  <= ac1[0];
            k1[0]  <= k0[0];
            k2[0]  <= k1[0];
            
            ac2[2] <= 0;
            ac2[1] <= ac2[2];
            ac2[0] <= ac2[1];
            k0[1]  <= ac2[0];
            k3[1]  <= k0[1];
            k6[1]  <= k3[1];
            
            sum[0] <= sum[0] + ((k0[1] * k0[0])  >>> 6);
            sum[1] <= sum[1] + ((k1[1] * k1[0])  >>> 6);
            sum[2] <= sum[2] + ((k2[1] * k2[0])  >>> 6);
            sum[3] <= sum[3] + ((k3[1] * k3[0])  >>> 6);
            sum[4] <= sum[4] + ((k4[1] * k4[0])  >>> 6);
            sum[5] <= sum[5] + ((k5[1] * k5[0])  >>> 6);
            sum[6] <= sum[6] + ((k6[1] * k6[0])  >>> 6);
            sum[7] <= sum[7] + ((k7[1] * k7[0])  >>> 6);
            sum[8] <= sum[8] + ((k8[1] * k8[0])  >>> 6);
            
            end        
        end

    endcase
    
end

endmodule