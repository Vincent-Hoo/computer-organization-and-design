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
    input wire middle_set, //�����м䰴ť
    input wire [3:0] score,
    output reg [1:0] mode //�����м����ʼ��Ϸ��00δ��ʼ��Ϸ��01������Ϸ��10������11ͨ�أ�Ĭ��00��
    );
    initial mode <= 0;
    
    always @ ( * )
        begin
            if (middle_set == 1 && mode != 01) mode <= 1;
            if (score == 13) mode <= 3;
            else if (score == 15) mode <= 2;
        end
    
endmodule
