`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/12 20:13:38
// Design Name: 
// Module Name: scroll_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module clkdiv(
    input wire clk,
    input wire clr,
    output wire clk190,
    output wire clk3
    );
    
    reg [30:0] div;
    
    always @( posedge clk or posedge clr)
    begin
        if(clr == 1)
            div <= 0;
        else 
            div <= div + 1;
    end
    
    assign clk190 = div[17];
    assign clk3 = div[26];
    
endmodule


module movement(
    input wire clk,
    input wire clr,
    input wire pause,
    output wire [15:0] x
    );
    
    reg [0:87] c;//表示要显示的一串数
    parameter chunk = 88'hFFF0ABCC0FF15352114FFF;
    
    always @(posedge clk or posedge clr)
    begin   
        if( clr == 1 )
            c <= chunk;
        else
            begin  
               if( pause == 0)
                   begin      
                       c[0:83] <= c[4:87];
                       c[84:87] <= c[0:3];
                   end
              end
    end
    
    
    assign x = c[72:87];
    
endmodule


module seg7(
    input wire clk,
    input wire clr,
    input wire [15:0] x,//需要显示的那4个数，每个数用4位二进制来表示
    output reg [3:0] an,//表示数码管的段选位，an=0为点亮
    output reg [6:0] a_to_g,//表示数码管的7段码
    output wire dp//dot
    );
    
    reg [2:0] s=0;
       reg [3:0] number;
       wire [3:0] enable;
       reg [19:0] clkdiv=0;
       parameter T=50000;
       
       assign dp = 1;
       assign enable = 4'b1111;
   
   
       always @(posedge clk)
       begin
               clkdiv <= clkdiv + 1;
               if( clkdiv == T )
               begin 
                   clkdiv <= 0;
                   s <= s + 1;
                   if( s == 4 )
                       s <= 0;
               end
           end
       
       always @( * )   
           case(s)
               0: number = x[3:0];
               1: number =x[7:4];
               2: number =x[11:8];
               3: number =x[15:12];
               default: number = x[3:0];
           endcase
   
   
       always @( posedge clk)
           case(s)
               0: an<=4'b1110;
               1: an<=4'b1101;
               2: an<=4'b1011;
               3: an<=4'b0111;
               default: an<=4'b1111;
           endcase
       
       always @(*)
           case(number)
               0: a_to_g = 7'b0000001;
               1: a_to_g = 7'b1001111;
               2: a_to_g = 7'b0010010;
               3: a_to_g = 7'b0000110;
               4: a_to_g = 7'b1001100;
               5: a_to_g = 7'b0100100;
               6: a_to_g = 7'b0100000;
               7: a_to_g = 7'b0001111;
               8: a_to_g = 7'b0000000;
               9: a_to_g = 7'b0000100;
               'hA: a_to_g = 7'b0000001;
               'hB: a_to_g = 7'b0000001;
               'hC: a_to_g = 7'b0000001;
               'hD: a_to_g = 7'b0000001;
               'hE: a_to_g = 7'b0000001;
               'hF: a_to_g = 7'b0000001;
               default: a_to_g = 7'b0000001;
           endcase
       
endmodule


module scroll_top(
    input clk,
    input clr,
    input pause,
    output [6:0] a_to_g,
    output [3:0] an,
    output dp
    );
    
    wire clk190;
    wire clk3;
    wire [15:0] x;
   // assign x = 4'h6666;
    
    clkdiv cd(.clk(clk), .clr(clr), .clk190(clk190), .clk3(clk3));
    movement m(.clk(clk3), .clr(clr), .pause(pause), .x(x));
    seg7 s(.clk(clk), .clr(clr), .x(x), .an(an), .a_to_g(a_to_g), .dp(dp));
endmodule
