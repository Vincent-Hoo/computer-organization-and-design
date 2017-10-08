`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/25 00:56:36
// Design Name: 
// Module Name: LED_igniting
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


module LED_igniting(

    );

    reg clk;
    reg src;
    reg state;
    
    initial begin
        clk = 0;
        state = 0;
        src = 0;
    end
    
    always #5 clk = ~clk;
    
    always@ (posedge clk) begin
        src = ~src;
    end
    
    always@ (posedge clk) begin
        if(src == 0)
            state = 1;
        else 
            state = 0;
    end
    
    
    
endmodule
