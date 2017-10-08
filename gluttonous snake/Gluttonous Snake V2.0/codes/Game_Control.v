`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/23 21:55:34
// Design Name: 
// Module Name: Game_Control
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


module Game_Control(
    input wire middle_set, //传入中间按钮
    input wire [3:0] score,
    output reg [1:0] mode //按下中间键开始游戏，00未开始游戏，01正在游戏，10死亡，11通关，默认00；
    );
    initial mode <= 0;
    
    always @ ( * )
        begin
            if (middle_set == 1 && mode != 01) mode <= 1;
            if (score == 13) mode <= 3;
            else if (score == 15) mode <= 2;
        end
    
endmodule
