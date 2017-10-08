`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 15:22:40
// Design Name: 
// Module Name: Mux_display
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


module Mux_display(
    input wire choice,
    input wire [1:0] s,
    input wire [2:0] s1,
    input wire [31:0] curPC,
    input wire [31:0] nextPC,
    input wire [31:0] ALU_inputA,
    input wire [31:0] ALU_inputB,
    input wire [31:0] RD_data1,
    input wire [31:0] RD_data2,
    input wire [31:0] ALU_result,
    input wire [31:0] memory_out,
    input wire [31:0] re0, re1, re2, re3, re4, re5, re6, re7,
    output reg [15:0] num
    );
    
    always@ (*) begin
        if(choice == 0) begin
            case(s)
                0 : num = {curPC[7:0], nextPC[7:0]};
                1 : num = {ALU_result[7:0], memory_out[7:0]};
                2 : num = {ALU_inputA[7:0], ALU_inputB[7:0]};
                3 : num = {RD_data1[7:0], RD_data2[7:0]};
                default : num = {curPC[7:0], nextPC[7:0]};
            endcase
        end
        
        else begin
            case(s1)
                0 : num = re0[15:0];
                1 : num = re1[15:0];
                2 : num = re2[15:0];
                3 : num = re3[15:0];
                4 : num = re4[15:0];
                5 : num = re5[15:0];
                6 : num = re6[15:0];
                7 : num = re7[15:0];
            endcase
        end
    end
    
endmodule
