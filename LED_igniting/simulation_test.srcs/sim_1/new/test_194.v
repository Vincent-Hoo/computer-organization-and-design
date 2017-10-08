`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/23 20:43:40
// Design Name: 
// Module Name: test_194
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


module test_194(

    input wire clk,
    output reg [3:0] clkdiv
    );

        
     reg [1:0] s=0;

    always @(posedge clk)
    begin
            s <= s + 1;
            
    end
    
    always @(*)
    begin
        case(s)
            0: clkdiv <= 4'b1000;
            1: clkdiv <= 4'b0100;
            2: clkdiv <= 4'b0010;
            3: clkdiv <= 4'b0001;
            default: clkdiv <= 4'b0000;
        endcase
    end
endmodule
