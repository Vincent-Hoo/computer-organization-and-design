`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 15:43:37
// Design Name: 
// Module Name: Mux_ALUSrc
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


module Mux_ALUSrcB(
    input [31:0] BDR_out,
    input ALUSrcB,   
    input [31:0] ext_immediate,
    output reg [31:0] ALU_inputB
    );
    
    always@ (*) begin
        if( ALUSrcB == 1)
            ALU_inputB = ext_immediate;
        else
            ALU_inputB = BDR_out;
    end
endmodule
