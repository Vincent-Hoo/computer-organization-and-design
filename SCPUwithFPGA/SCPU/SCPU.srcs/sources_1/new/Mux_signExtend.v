`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 15:41:36
// Design Name: 
// Module Name: Mux_signExtend
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


module Mux_signExtend(
    input ExtSel,
    input [15:0] unextended,
    output reg [31:0] ext_immediate
    );
    
    always@ (*) begin
        if( ExtSel == 0 ) 
            ext_immediate = {4'h0000, unextended};
        
        else begin
            if( unextended[15] == 0 )// positive number
                ext_immediate = {16'b0000000000000000, unextended[15:0]};
            else // negative number
                ext_immediate = {16'b1111111111111111, unextended[15:0]};
        end
    end
endmodule
