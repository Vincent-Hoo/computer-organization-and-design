`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 15:45:15
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [2:0] ALUop,
    input [31:0] ALU_inputA,
    input [31:0] ALU_inputB,
    output reg [31:0] result,
    output reg zero
    );
    
    initial begin
        zero = 0;
    end
    
    always@ (*) begin
        case(ALUop)
            0 : result = ALU_inputA + ALU_inputB;
            1 : result = ALU_inputA - ALU_inputB;
            2 : result = ALU_inputB << ALU_inputA;
            3 : result = ALU_inputA | ALU_inputB;
            4 : result = ALU_inputA & ALU_inputB;
            5 : result = (~ALU_inputA) & ALU_inputB;
            6 : result = ALU_inputA ^ ALU_inputB;
            7 : result = ALU_inputA ~^ ALU_inputB;
            default : result = ALU_inputA + ALU_inputB;
        endcase      
    end
    
        
    always@ (*) begin
        if( result == 0)
            zero = 1;
        else
            zero = 0;
    end    
endmodule
