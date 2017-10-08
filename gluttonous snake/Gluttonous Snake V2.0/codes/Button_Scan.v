`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/23 18:35:29
// Design Name: 
// Module Name: Button_Scan
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
    input wire [4:0] button_in,//
    output wire middle, //0,消抖后的按键
    output wire up, //1
    output wire down,//2
    output wire left,//3
    output wire right //4
    );
    
    reg [15:0] delay_clk[4:0];//按键采样电容

    always @ (posedge clk)
        begin
        
            if( button_in[0] == 1 && delay_clk[0] < 65535 ) delay_clk[0] <= delay_clk[0] + 1;
            else if( button_in[0] == 0 && delay_clk[0] > 0) delay_clk[0] <= delay_clk[0] - 1;
            
            //
            
            if( button_in[1] == 1 && delay_clk[1] < 65535 ) delay_clk[1] <= delay_clk[1] + 1;
            else if( button_in[1] == 0 && delay_clk[1] > 0) delay_clk[1] <= delay_clk[1] - 1;
            
            //
            
            if( button_in[2] == 1 && delay_clk[2] < 65535 ) delay_clk[2] <= delay_clk[2] + 1;
            else if( button_in[2] == 0 && delay_clk[2] > 0) delay_clk[2] <= delay_clk[2] - 1;
            
            //
            
            if( button_in[3] == 1 && delay_clk[3] < 65535 ) delay_clk[3] <= delay_clk[3] + 1;
            else if( button_in[3] == 0 && delay_clk[3] > 0) delay_clk[3] <= delay_clk[3] - 1;
            
            //
            
            if( button_in[4] == 1 && delay_clk[4] < 65535 ) delay_clk[4] <= delay_clk[4] + 1;
            else if( button_in[4] == 0 && delay_clk[4] > 0) delay_clk[4] <= delay_clk[4] - 1;
            
            //
        end
        
    /****************************************************************************************************************************************/    
        
        reg [4:0] button_out;
        
        always @ ( * ) //按键消抖
            begin
                if(delay_clk[0] > 32767) button_out[0] <= 1;
                else button_out[0] <= 0;
                
                if(delay_clk[1] > 32767) button_out[1] <= 1;
                else button_out[1] <= 0;
                
                if(delay_clk[2] > 32767) button_out[2] <= 1;
                else button_out[2] <= 0;
                
                if(delay_clk[3] > 32767) button_out[3] <= 1;
                else button_out[3] <= 0;
                
                if(delay_clk[4] > 32767) button_out[4] <= 1;
                else button_out[4] <= 0;
            end
    
        assign middle = button_out[0];
        assign up = button_out[1];
        assign down = button_out[2];
        assign left = button_out[3];
        assign right = button_out[4];
        
endmodule
