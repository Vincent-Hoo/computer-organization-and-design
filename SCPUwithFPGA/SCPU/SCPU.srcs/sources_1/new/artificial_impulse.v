`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 14:59:12
// Design Name: 
// Module Name: artificial_impulse
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


module artificial_impulse(
    input wire button_after_scanning,
    output reg impulse
    );
    
    initial begin
        impulse = 1;
    end
    
    
    always@ (posedge button_after_scanning) begin
        impulse = ~impulse;
    end
endmodule
