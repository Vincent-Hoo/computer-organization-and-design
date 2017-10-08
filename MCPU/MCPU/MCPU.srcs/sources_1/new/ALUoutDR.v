`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/16 13:40:04
// Design Name: 
// Module Name: ALUoutDR
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


module ALUoutDR(
    input [31:0] result,
    input clk,
    output reg [31:0] ALUDR_out
    );
    
    always@ (posedge clk) begin
        ALUDR_out = result;
    end
    
endmodule
