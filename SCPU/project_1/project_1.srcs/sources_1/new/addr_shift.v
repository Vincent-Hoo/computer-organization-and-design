`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 15:55:13
// Design Name: 
// Module Name: addr_shift
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


module addr_shift(
    input [31:0] ext_immediate,
    output [31:0] ext_immediate_shift
    );
    
    assign ext_immediate_shift = ext_immediate << 2;
endmodule
