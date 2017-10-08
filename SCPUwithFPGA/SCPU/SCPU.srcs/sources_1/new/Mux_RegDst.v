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
    input Reg_Dst,
    input [4:0] rt,
    input [4:0] rd,
    output reg [4:0] WRaddr
    );
    
    always@ (*) begin
        if( Reg_Dst == 1 )
            WRaddr = rd;
        else
            WRaddr = rt;
    end
endmodule
