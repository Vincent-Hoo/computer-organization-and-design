`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/23 09:18:46
// Design Name: 
// Module Name: clk_10Hz
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


module clk_10Hz(

    );
    
    reg clk = 0;
    always #10 clk <= ~clk;
    reg [3:0] div = 0;
    reg d=0;
    always @(posedge clk)
    begin
        if(div == 9 )
        begin
            div <= 0;
            d <= 1;
        end
        else
        begin
            d <= 0;
            div <= div + 1;
        end
        
    end
    
    
endmodule
