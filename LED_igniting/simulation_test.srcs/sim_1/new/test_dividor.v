`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/23 08:57:09
// Design Name: 
// Module Name: test_dividor
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


module test_dividor(

    );
    
    reg clk = 0;
    always #10 clk <= ~clk;
    
    reg d = 0;
    reg [3:0] div = 0;
    parameter N = 9;
    
    dividor di(.clk(clk), .clk_10Hz(d));
endmodule
