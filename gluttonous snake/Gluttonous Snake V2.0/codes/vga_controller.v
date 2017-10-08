`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/20 14:54:22
// Design Name: 
// Module Name: vga_controller
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

//640*800 60Hz VGA����

 module vga_controller(
    //input wire clk, // 100MHz
    input wire clk_25MHz, //25MHz
    input wire rst_n, //��λ�źţ�rst_n == 1ʱ����ȫ��
    input wire [39:0] VRAM, //����һ��ģ�鴫������ͼ����Ϣ, ÿ2bits��¼һ�������ɫ����Ϣ
    output reg [5:0] y_pos, //���źŴ���Displayģ��
    output reg VGA_HS,//��ͬ���ź�
    output reg VGA_VS,//��ͬ���ź�
    output wire [3:0] VGA_R,
    output wire [3:0] VGA_G,
    output wire [3:0] VGA_B
    );
    
    parameter PAL = 640; // Pixels Active Line                  
    parameter LAF = 480; // Lines Active Frame                  
                                                                
    parameter PLD = 800; // Pixel Line Divider ��ʵ��ɨ������          
    parameter LFD = 521; // Line Frame Divider ��ʵ��ɨ������          
                                                                
    parameter HPW = 96; // Horizontal synchro Pulse Width ��ͬ������ 
    parameter HFP = 16; // Horizontal synchro Front Porch ����ʾǰ�� 
    parameter HBP = 48; // Horizontal synchro Back Porch ����ʾ����  
                                                                
    parameter VPW = 2;  // Vertical synchro Pulse Width ��ͬ������   
    parameter VFP = 10; // Vertical synchro Front Porch ����ʾǰ��   
    parameter VBP = 29; // Vertical synchro Back Porch  ����ʾ����   
    
    //reg [3:0] clkdiv;
    reg [10:1] x_counter;
    reg [10:0] y_counter;
    wire [2:0] RGB;
    
    reg Pixel;//16*16Ϊ1������
    reg [5:0] x_pos;
    //reg [5:0] y_pos;
    reg [4:0] i;
    reg [4:0] j;
    
    assign VGA_R[0] = RGB[2];
    assign VGA_R[1] = RGB[2];
    assign VGA_R[2] = RGB[2];
    assign VGA_R[3] = RGB[2];
    
    assign VGA_G[0] = RGB[1];
    assign VGA_G[1] = RGB[1];
    assign VGA_G[2] = RGB[1];
    assign VGA_G[3] = RGB[1];
    
    assign VGA_B[0] = RGB[0];
    assign VGA_B[1] = RGB[0];
    assign VGA_B[2] = RGB[0];
    assign VGA_B[3] = RGB[0];
    
    reg [2:0] Color;
    assign RGB = Color;
    
/*****************************************************************************************************************************/
    
    reg y_cnt_pulse;

    initial begin
        x_counter = 0;
        y_counter = 0;
        y_cnt_pulse = 1;
        
        x_pos <= 0;
        y_pos <= 0;
    end

/*****************************************************************************************************************************/



always @(posedge clk_25MHz)
    begin
    
        if(x_counter == 799) begin //PLD = 800
            x_counter <= 0;
            if(y_counter == 520) begin
                 y_counter <= 0; //LFD = 521
                 VGA_VS <= 0;
            end
            else begin 
                 y_counter <= y_counter + 1; //���ź� + 1
            end
            y_cnt_pulse <= y_cnt_pulse + 1;
        end
        else if (x_counter == 499) begin
            x_counter <= x_counter + 1;
            y_cnt_pulse <= y_cnt_pulse + 1;
        end
        else if (x_counter == 0)//�µ�һ�У���x_counter = 96֮ǰ��ͬ���ź�Ϊ�͵�ƽ
            begin 
                VGA_HS <= 0;
                x_counter <= x_counter + 1;
            end
        else if(x_counter == 95) //HPW = 96��ͬ������ʱ���ѹ���������ͬ���źŵ�ƽ
            begin
                VGA_HS <= 1;
                x_counter <= x_counter + 1;
            end
        else 
            x_counter <= x_counter + 1;
       
       //��ɨ�輰��ͬ���ź�
       
        if (y_counter == 0) //�µ�һ֡����y_counter = 2֮ǰ��ͬ���ź�Ϊ�͵�ƽ
            VGA_VS <= 0;
        else if (y_counter == 1) //VPW = 2��ͬ������ʱ���ѹ���������ͬ���źŵ�ƽ
            VGA_VS <= 1;
        
    end
    
    //������ͬ���ͳ�ͬ�����塢��ǰ��������
 
/*****************************************************************************************************************************/
 
    
    
    /*
    x_counter - HPW - HFP
    
    0~15
    16~31
    31~
    */
    
    
    always @ (posedge clk_25MHz) begin
    
        if(x_counter >  143 && x_counter < 784) begin //HPW + HBP = 48 + 96 = 144
            if(i == 15) begin 
                i <= 0;
                if(x_pos == 39) x_pos <= 0;
                else x_pos <= x_pos + 1;
            end
            else
                i <= i + 1;
        end
        else begin 
            x_pos <= 0;
            i <= 0;
        end
    end //x_counterÿ��16�Σ�x_pos += 1, x_pos = 0~39
    
    
    always @ (posedge y_cnt_pulse) begin
            if(y_counter > 30 && y_counter < 511) begin
                if(j == 15) begin 
                    j <= 0;
                    if(y_pos == 29) y_pos <= 0;
                    else y_pos <= y_pos + 1;
                end
                else
                    j <= j + 1;
            end
            else begin
                j <= 0;
                y_pos <= 0;
            end
    end //y_counterÿ��16�Σ�y_pos += 1, y_pos = 0~29
    
    always @ (x_pos) begin
          case(x_pos)
            0: Pixel <= 1;
            1: Pixel <= VRAM[1];
            2: Pixel <= VRAM[2];
            3: Pixel <= VRAM[3];
            4: Pixel <= VRAM[4];
            5: Pixel <= VRAM[5];
            6: Pixel <= VRAM[6];
            7: Pixel <= VRAM[7];
            8: Pixel <= VRAM[8];
            9: Pixel <= VRAM[9];
            0: Pixel <= VRAM[0];
            10: Pixel <= VRAM[10];
            11: Pixel <= VRAM[11];
            12: Pixel <= VRAM[12];
            13: Pixel <= VRAM[13];
            14: Pixel <= VRAM[14];
            15: Pixel <= VRAM[15];
            16: Pixel <= VRAM[16];
            17: Pixel <= VRAM[17];
            18: Pixel <= VRAM[18];
            19: Pixel <= VRAM[19];
            20: Pixel <= VRAM[20];
            21: Pixel <= VRAM[21];
            22: Pixel <= VRAM[22];
            23: Pixel <= VRAM[23];
            24: Pixel <= VRAM[24];
            25: Pixel <= VRAM[25];
            26: Pixel <= VRAM[26];
            27: Pixel <= VRAM[27];
            28: Pixel <= VRAM[28];
            29: Pixel <= VRAM[29];
            30: Pixel <= VRAM[30];
            31: Pixel <= VRAM[31];
            32: Pixel <= VRAM[32];
            33: Pixel <= VRAM[33];
            34: Pixel <= VRAM[34];
            35: Pixel <= VRAM[35];
            36: Pixel <= VRAM[36];
            37: Pixel <= VRAM[37];
            38: Pixel <= VRAM[38];
            39: Pixel <= 1;
            default: Pixel <= 0;
          endcase
          if(y_pos == 0 || y_pos == 29) Pixel <= 1;
    end
    
    always @ (*) begin
        case (Pixel)
            0: Color <= 3'b000; //��
            1: Color <= 3'b111; //��
            default: Color <= 3'b000; //��
        endcase
    end
    
    
    //��Ϸ��ֻ�õ�������ɫ
 
/*****************************************************************************************************************************/

/* 
    always @ (*) begin
       if(x_counter - HPW  - HFP < 80) RGB <= 3'b001;
       else if(x_counter - HPW  - HFP < 160) RGB <= 3'b010;
       else if(x_counter - HPW  - HFP < 240) RGB <= 3'b011;
       else if(x_counter - HPW  - HFP < 320) RGB <= 3'b100;
       else if(x_counter - HPW  - HFP < 400) RGB <= 3'b101;
       else if(x_counter - HPW - HFP < 480) RGB <= 3'b110;
       else if(x_counter - HPW - HFP < 560) RGB <= 3'b111;
       else RGB <= 3'b000;
    end
*/

//���ڲ���VGA���Ч��

/*****************************************************************************************************************************/



/*****************************************************************************************************************************/
    
endmodule
