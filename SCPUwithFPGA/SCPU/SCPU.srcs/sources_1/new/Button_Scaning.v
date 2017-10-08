`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 14:07:38
// Design Name: 
// Module Name: Button_Scaning
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

module Button_Scaning(
    input wire clk, //25MHz
    input wire button_in,
    output wire button_out
    );
    
    reg [15:0] delay_clk;//按键电容

    always @ (posedge clk) begin
        if( button_in == 1 && delay_clk < 65535 ) 
            delay_clk <= delay_clk + 1;
        else if( button_in == 0 && delay_clk > 0) 
            delay_clk <= delay_clk - 1;
    end
        
    /****************************************************************************************************************************************/    
      
    reg out;
        
    always @ ( * ) begin //按键消抖
        if(delay_clk > 32767)   
            out <= 1;
        else  
            out <= 0;            
    end
    
    assign button_out = out;

        
endmodule

