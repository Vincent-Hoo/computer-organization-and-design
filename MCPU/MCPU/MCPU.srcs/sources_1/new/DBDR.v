`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/16 13:42:14
// Design Name: 
// Module Name: DBDR
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


module DBDR(
    input [31:0] DBDR_in,
    input clk,
    output reg [31:0] DBDR_out
    );
    
    always@ (posedge clk) begin
        DBDR_out = DBDR_in;
    end
    
endmodule
