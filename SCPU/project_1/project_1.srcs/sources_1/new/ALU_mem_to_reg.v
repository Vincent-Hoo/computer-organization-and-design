`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 16:44:03
// Design Name: 
// Module Name: ALU_mem_to_reg
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


module Mux_ALU_memory_to_reg(
    input DBdataSrc,
    input [31:0] result,
    input [31:0] memory_out,
    output reg [31:0] DBDR_in
    );
    
    always@ (*) begin
        if(DBdataSrc == 0)
            DBDR_in = result;
        else
            DBDR_in = memory_out;
    end
endmodule
