`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 14:52:44
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input wire clk,
    output wire clk_25MHz,
    output wire clk_1kHz //119Hz
);
    
    reg [28:0]clkdiv;
    
    
    initial begin
        clkdiv <= 0;
    end
    
    
    assign clk_25MHz = clkdiv[1];
    assign clk_1kHz = clkdiv[17];


    always @ (posedge clk)
    begin
        clkdiv <= clkdiv + 1;
    end

endmodule
