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


module Mux_ALUSrc(
    input ALU_SrcB,
    input [31:0] RD_data2,
    input [31:0] ext_immediate,
    output reg [31:0] ALU_inputB
    );
    
    always@ (*) begin
        if( ALU_SrcB == 1)
            ALU_inputB = ext_immediate;
        else
            ALU_inputB = RD_data2;
    end
endmodule
