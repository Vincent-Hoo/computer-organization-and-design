`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/16 13:45:33
// Design Name: 
// Module Name: jumpInsExtend
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


module jumpInsExtend(
    input [31:0] PC,
    input [25:0] jumpAddr_unextend,
    output [31:0] jumpAddr_extend
    );
    
    assign jumpAddr_extend = {PC[31:28], jumpAddr_unextend, 2'b00};
    
endmodule
