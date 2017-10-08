`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/23 09:03:52
// Design Name: 
// Module Name: dividor
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


module seg7(

    input wire clk,
    output reg [2:0] s
  //  input wire clr,

    );
    
   // reg [2:0] s=0;
   // reg [3:0] number;
    reg [3:0] clkdiv=0;
    parameter T=12;



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
    


    

    
endmodule