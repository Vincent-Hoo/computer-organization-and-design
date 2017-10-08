`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/16 14:13:03
// Design Name: 
// Module Name: Mux_ALUSrcA
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


module Mux_ALUSrcA(
    input [31:0] ADR_out,
    input ALUSrcA,
    input [4:0] sa,
    output reg [31:0] ALU_inputA
    );
    
    always@ (*) begin
            if( ALUSrcA == 1)
                ALU_inputA = {27'b000000000000000000000000000, sa};
            else
                ALU_inputA = ADR_out;
    end
    
endmodule
