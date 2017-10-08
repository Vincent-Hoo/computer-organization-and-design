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

//640*800 60Hz VGA驱动

 module vga_controller(
    //input wire clk, // 100MHz
    input wire clk_25MHz, //25MHz
    input wire rst_n, //复位信号，rst_n == 1时画面全黑
    input wire [39:0] VRAM, //从另一个模块传过来的图像信息, 每2bits记录一个坐标的色彩信息
    output reg [5:0] y_pos, //行信号传给Display模块
    output reg VGA_HS,//行同步信号
    output reg VGA_VS,//场同步信号
    output wire [3:0] VGA_R,
    output wire [3:0] VGA_G,
    output wire [3:0] VGA_B
    );
    
    parameter PAL = 640; // Pixels Active Line                  
    parameter LAF = 480; // Lines Active Frame                  
                                                                
    parameter PLD = 800; // Pixel Line Divider 行实际扫描像素          
    parameter LFD = 521; // Line Frame Divider 列实际扫描像素          
                                                                
    parameter HPW = 96; // Horizontal synchro Pulse Width 行同步脉冲 
    parameter HFP = 16; // Horizontal synchro Front Porch 行显示前沿 
    parameter HBP = 48; // Horizontal synchro Back Porch 行显示后沿  
                                                                
    parameter VPW = 2;  // Vertical synchro Pulse Width 场同步脉冲   
    parameter VFP = 10; // Vertical synchro Front Porch 场显示前沿   
    parameter VBP = 29; // Vertical synchro Back Porch  场显示后沿   
    
    //reg [3:0] clkdiv;
    reg [10:1] x_counter;
    reg [10:0] y_counter;
    wire [2:0] RGB;
    
    reg Pixel;//16*16为1个像素
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
                 y_counter <= y_counter + 1; //行信号 + 1
            end
            y_cnt_pulse <= y_cnt_pulse + 1;
        end
        else if (x_counter == 499) begin
            x_counter <= x_counter + 1;
            y_cnt_pulse <= y_cnt_pulse + 1;
        end
        else if (x_counter == 0)//新的一行，在x_counter = 96之前行同步信号为低电平
            begin 
                VGA_HS <= 0;
                x_counter <= x_counter + 1;
            end
        else if(x_counter == 95) //HPW = 96，同步脉冲时间已过，拉高行同步信号电平
            begin
                VGA_HS <= 1;
                x_counter <= x_counter + 1;
            end
        else 
            x_counter <= x_counter + 1;
       
       //行扫描及行同步信号
       
        if (y_counter == 0) //新的一帧，在y_counter = 2之前场同步信号为低电平
            VGA_VS <= 0;
        else if (y_counter == 1) //VPW = 2，同步脉冲时间已过，拉高行同步信号电平
            VGA_VS <= 1;
        
    end
    
    //更改行同步和场同步脉冲、当前像素坐标
 
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
    end //x_counter每变16次，x_pos += 1, x_pos = 0~39
    
    
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
    end //y_counter每变16次，y_pos += 1, y_pos = 0~29
    
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
            0: Color <= 3'b000; //黑
            1: Color <= 3'b111; //白
            default: Color <= 3'b000; //黑
        endcase
    end
    
    
    //游戏中只用到两种颜色
 
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

//用于测试VGA输出效果

/*****************************************************************************************************************************/



/*****************************************************************************************************************************/
    
endmodule
