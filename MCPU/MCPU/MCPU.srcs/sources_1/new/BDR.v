`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/16 13:38:39
// Design Name: 
// Module Name: BDR
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


module BDR(
    input [31:0] RD_data2,
    input clk,
    output reg [31:0] BDR_out
    );
    
    always@ (posedge clk) begin
        BDR_out = RD_data2;
    end
    
endmodule
