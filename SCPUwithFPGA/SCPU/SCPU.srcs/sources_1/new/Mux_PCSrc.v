`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 15:57:26
// Design Name: 
// Module Name: Mux_PCSrc
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


module Mux_PCSrc(
    input PCSrc,
    input [31:0] curPC,
    input [31:0] ext_immediate_shift,
    input zero,
    output reg [31:0] nextPC
    );
    
    always@ (*) begin
        if( PCSrc == 0 )
            nextPC = curPC + 4;
            
        else begin 
            if( zero == 0 )
                nextPC = curPC + 4;
            else begin
                nextPC = curPC + 4;
                nextPC = nextPC + ext_immediate_shift;
            end
        end
    end
    
endmodule
