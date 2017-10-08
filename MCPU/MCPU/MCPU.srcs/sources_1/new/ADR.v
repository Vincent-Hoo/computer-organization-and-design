`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/16 13:37:35
// Design Name: 
// Module Name: ADR
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


module ADR(
    input [31:0] RD_data1,
    input clk,
    output reg [31:0] ADR_out
    );
    
    always@ (posedge clk) begin
        ADR_out = RD_data1;
    end
    
endmodule
