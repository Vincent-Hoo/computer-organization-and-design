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
    input [1:0] PCSrc,
    input [31:0] curPC,
    input [31:0] ext_immediate_shift,
    input [31:0] RD_data1,
    input [31:0] jumpAddr_extend,
    output reg [31:0] nextPC
    );
    
    initial begin
        nextPC = 0;
    end
    
    always@ (*) begin
        if( PCSrc == 0 )
            nextPC = curPC + 4;
           
        else if( PCSrc == 1 ) begin 
                nextPC = curPC + 4;
                nextPC = nextPC + ext_immediate_shift;
        end
        
        else if( PCSrc == 2 )
            nextPC = RD_data1;
        
        else if( PCSrc == 3 )
            nextPC = jumpAddr_extend;
    end
    
endmodule
