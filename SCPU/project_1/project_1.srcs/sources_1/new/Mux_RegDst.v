`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 15:38:58
// Design Name: 
// Module Name: Mux_RegDst
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


module Mux_RegDst(
    input [1:0] RegDst,
    input [4:0] rt,
    input [4:0] rd,
    output reg [4:0] WR_reg_addr
    );
    
    always@ (*) begin
        if( RegDst == 2 )
            WR_reg_addr = rd;
        else if( RegDst == 1 )
            WR_reg_addr = rt;
        else if( RegDst == 0 )
            WR_reg_addr = 5'b11111;
    end
endmodule
