`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/23 08:17:18
// Design Name: 
// Module Name: ten_Hz_tb
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


module ten_Hz_tb;

    reg clk=0;
    always #10 clk <= ~clk;
    reg clr = 0;
    
    reg [3:0] div = 0;
    
    always @(posedge clk)
    begin
        div <= div + 1;
    end
    
    
//    reg ten_Hz_clk = 0;
//    #parameter N = 9;
//    reg [4:0] d;
//    always @(posedge clk)
//    begin

//                if( d == N )
//                begin
//                   ten_Hz_clk <= 1;
//                    d <= 0;
//                end
//                else
//                begin
//                    ten_Hz_clk <= 0;
//                    d <= d + 1;
//                end
//    end
    
    
    
    
    
endmodule
