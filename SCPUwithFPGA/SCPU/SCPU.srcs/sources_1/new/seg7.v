`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 14:06:27
// Design Name: 
// Module Name: seg7
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


module seg7(
    input wire [15:0] x,
    input wire clk,
    input wire clr,
    output reg [3:0] an,
    output reg [6:0] a_to_g,
    output wire dp
    );
    
    
    reg [2:0] s=0;
    reg [3:0] number;
    
    assign dp = 1;
    assign enable = 4'b1111;


    always @(posedge clk)
    begin
        s <= s + 1;
        if( s == 4 )
            s <= 0;
        end
    
    always @( * )   
        case(s)
            0: number = x[3:0];
            1: number = x[7:4];
            2: number = x[11:8];
            3: number = x[15:12];
            default: number = x[3:0];
        endcase


    always @( * )
        case(s)
            0: an<=4'b1110;
            1: an<=4'b1101;
            2: an<=4'b1011;
            3: an<=4'b0111;
            default: an<=4'b1111;
        endcase
    
    always @(*)
        case(number)
            0: a_to_g = 7'b0000001;
            1: a_to_g = 7'b1001111;
            2: a_to_g = 7'b0010010;
            3: a_to_g = 7'b0000110;
            4: a_to_g = 7'b1001100;
            5: a_to_g = 7'b0100100;
            6: a_to_g = 7'b0100000;
            7: a_to_g = 7'b0001111;
            8: a_to_g = 7'b0000000;
            9: a_to_g = 7'b0000100;
            'hA: a_to_g = 7'b0001000;
            'hB: a_to_g = 7'b1100000;
            'hC: a_to_g = 7'b0110001;
            'hD: a_to_g = 7'b1000010;
            'hE: a_to_g = 7'b0110000;
            'hF: a_to_g = 7'b0111000;
            default: a_to_g = 7'b0000001;
        endcase
    

    
endmodule  
