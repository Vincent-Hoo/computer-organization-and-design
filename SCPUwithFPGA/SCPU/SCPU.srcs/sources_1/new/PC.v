`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 14:11:33
// Design Name: 
// Module Name: PC
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


//在时钟上升沿，将nextPC的地址赋值给curPC，nextPC从Mux_PCSrc传出来
module PC(
    input clk,
    input reset,
    input PCWre,
    input [31:0] nextPC,
    output reg [31:0] curPC
    );
    
    initial begin
        curPC = 0;
    end
    
    always@ (posedge clk) begin
        if(reset == 0)
            curPC = 0;
        else if ( PCWre == 1)
            curPC = nextPC;
    end

    
endmodule