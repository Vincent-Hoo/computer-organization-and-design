`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/23 08:37:22
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
    reg [3:0] div = 0;
    
    always @(posedge clk)
    begin
        div <= div + 1;
    end
endmodule
