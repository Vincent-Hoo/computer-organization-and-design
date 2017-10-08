`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/15 14:21:18
// Design Name:  clock
// Module Name: counter_top
// Project Name: clock
// Target Devices: none
// Tool Versions: Version 10000
// Description: it's a incredible device!!
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////








//左数第一个slide switch是切换秒表和时钟的开关，左数第二个是开启闹钟模式的开关，右数第一个是设置时间的开关，右数第二个是切换数码管显示内容的开关
//T18按钮是秒表的暂停按钮，T17是秒表的reset按钮，W19是时钟进位的按钮，U18是时钟加一的按钮
//温馨提示：在设置时间的时候，在按加一按钮和进位按钮时，按着不松，效果更佳
//设置闹钟的时候，先开启闹钟模式的开关，即T1 slide switch，再开启设置时间的开关，V17，再进行时间的设置，设置完成后，请将设置开关调至为0，等待灯光秀
//注意一下，我的板子的第一个LED貌似坏了，所以L0的IO没有设置成功，所以也就看不到L0会亮
//时钟初始时间为10：35，打开后请自行调节

module twentyfiveMhz (
    input wire clk,
    input wire clr,
    output wire clk_25mhz
    );
    
    reg [3:0] clkdiv;
    
    initial
    begin
        clkdiv <= 0;
    end
    
    always @(posedge clk)
    begin
        clkdiv <= clkdiv + 1;
    end
    
    assign clk_25mhz = clkdiv[1];
    
endmodule


module one_second #(parameter N=99999999)(
    input wire clk,
    input wire clr,
    output reg one_second_clk
    );
    
    reg [31:0] div;
    
    always @(posedge clk or posedge clr)
    begin
        if( clr == 1 )
            div <= 0;
        else
        begin
            if( div == N )
            begin
                one_second_clk <= 1;
                div <= 0;
            end
            else
            begin
                one_second_clk <= 0;
                div <= div + 1;
            end
        end
    end
 
endmodule


module ten_Hz #(parameter N=9999999)(
    input wire clk,
    input wire clr,
    output reg ten_Hz_clk
    );
    
    reg [31:0] div;
    
    always @(posedge clk or posedge clr)
    begin
        if( clr == 1 )
            div <= 0;
        else
        begin
            if( div == N )
            begin
               ten_Hz_clk <= 1;
                div <= 0;
            end
            else
            begin
                ten_Hz_clk <= 0;
                div <= div + 1;
            end
        end
    end
 
endmodule


module sixty_Hz #(parameter N=1666667)(
    input wire clk,
    input wire clr,
    output reg sixty_Hz_clk
    );
    
    reg [31:0] div;
    
    always @(posedge clk or posedge clr)
    begin
        if( clr == 1 )
            div <= 0;
        else
        begin
            if( div == N )
            begin
               sixty_Hz_clk <= 1;
                div <= 0;
            end
            else
            begin
                sixty_Hz_clk <= 0;
                div <= div + 1;
            end
        end
    end
 
endmodule

//消抖模块
module button(
    input wire button_in,
    input wire clk,//采集时钟 25mhz
    output wire button_out
    );
    
    
//    reg BUTTON_IN_Q, BUTTON_IN_2Q, BUTTON_IN_3Q;
//    always @(posedge clk)
//    begin
//        BUTTON_IN_Q <= button_in;
//        BUTTON_IN_2Q <= BUTTON_IN_Q;
//        BUTTON_IN_3Q <= BUTTON_IN_2Q;        
//    end
//    assign button_out = BUTTON_IN_3Q;

/*
    reg BUTTON;
    
    always @(posedge clk )
    begin
        if(button_in)
            BUTTON = 1;
        else
            BUTTON = 0;
    end
    
    assign button_out = BUTTON;    
*/


    reg [15:0] delay_clk;
    
    always @(posedge clk)
    begin
        if(button_in == 1 && delay_clk < 65535)
            delay_clk <= delay_clk + 1;
        else if(button_in == 0 && delay_clk > 0)
            delay_clk <= delay_clk - 1;  
    end
    
    reg out;
    
    always @(*)
    begin
        if(delay_clk > 32767)
            out <= 1;
        else
            out <= 0;
    end
        
    assign button_out = out;
endmodule




module electronic_clock #(parameter N1 = 9, N2 = 5, N3 = 2, N4 = 3) (
    input wire one_second_clk,
    input wire clk_10Hz,
    input wire clk_25mhz,
    input wire alarm_clock_mode,//slide switch, 1 for setting alarm_clock mode
    input wire set,//slide switch，设置时间
    input wire shift,//slide switch，切换数码管显示的数字，shift = 0 为显示分和秒， 1 为显示时分
    input wire addOne,//加一
    input wire carryOut,//进位
    output reg [15:0] x,
    output reg L0,
    output reg L1,
    output reg L2,
    output reg L3,
    output reg L4,
    output reg L5,
    output reg L6,
    output reg L7,
    output reg L8,
    output reg L9,
    output reg L10,
    output reg L11,
    output reg L12,
    output reg L13,
    output reg L14,
    output reg L15
    );
    
    wire add,carry;//这些是经过消抖后的信号
    reg flag = 1;//flag = 1 表示闹钟设置不是全部为0
    
    //这里有两个选择器，select是用来选择加一的时候究竟加在哪一位上的；s是闹钟到时间后，灯光闪烁的8个状态
    reg [2:0] select = 3'b000;
    reg [2:0] s = 3'b000;
    
    reg [3:0] cnt1 = 4'b0000;//秒针个位计数器
    reg [3:0] cnt2 = 4'b0000;//秒针十位计数器
    reg [3:0] cnt3 = 4'b0101;//分针个位计数器
    reg [3:0] cnt4 = 4'b0011;//分针十位计数器
    reg [3:0] cnt5 = 4'b0000;//时针个位计数器
    reg [3:0] cnt6 = 4'b0001;//时针十位计数器
    
    reg [3:0] alarm_clock_cnt1 = 4'b0000;//闹钟秒针个位计数器
    reg [3:0] alarm_clock_cnt2 = 4'b0000;//闹钟秒针十位计数器
    reg [3:0] alarm_clock_cnt3 = 4'b0000;//闹钟分针个位计数器
    reg [3:0] alarm_clock_cnt4 = 4'b0000;//闹钟分针十位计数器
    reg [3:0] alarm_clock_cnt5 = 4'b0000;//闹钟时针个位计数器
    reg [3:0] alarm_clock_cnt6 = 4'b0000;//闹钟时针十位计数器    
    
    reg  alarm_clock_arrive_time = 0;   //一个表示闹钟到时间的变量 
    
    //两个消抖模块
    button ab(.button_in(addOne), .clk(clk_25mhz), .button_out(add));
    button cb(.button_in(carryOut), .clk(clk_25mhz), .button_out(carry));
    
    
    
    always @(*)
    begin
        if( alarm_clock_cnt1 == 0 && alarm_clock_cnt2 == 0 && alarm_clock_cnt3 == 0 && alarm_clock_cnt4 == 0 && alarm_clock_cnt5 == 0 && alarm_clock_cnt6 == 0 )
            flag <= 0;
        else
            flag <= 1;
    end
    
    
    //这是电子钟本身时间的一个芯片，包含有设置时间和最主要的时钟的性质，满60进1
    always @(posedge one_second_clk)
    begin
        //设置时间
        if( alarm_clock_mode == 0 && set == 1 )
        begin
            if( add == 1 )
            begin
                if( select == 0 )
                begin
                    if(cnt1 == N1)
                        cnt1 <= 0;
                    else    
                        cnt1 <= cnt1 + 1;
                end
                
                else if( select == 1 )
                begin
                    if( cnt2 == N2 )
                        cnt2 <= 0;
                    else
                        cnt2 <= cnt2 + 1;
                end
                
                else if( select == 2 )
                begin
                    if( cnt3 == N1 )
                        cnt3 <= 0;
                    else
                        cnt3 <= cnt3 + 1;
                end
                
                else if( select == 3 )
                begin
                    if( cnt4 == N2 )
                        cnt4 <= 0;
                    else
                        cnt4 <= cnt4 + 1;
                end
                
                else if( select == 4 )
                begin
                    if( cnt5 == N1 )
                        cnt5 <= 0;
                    else
                        cnt5 <= cnt5 + 1;
                end
                
                else if( select == 5 )
                begin
                    if( cnt6 == N3 )
                        cnt6 <= 0;
                    else
                        cnt6 <= cnt6 + 1;
                end 
            end
        end
        
        
        if( (alarm_clock_mode == 0 && set == 0) || alarm_clock_mode == 1 )
        begin
            if( cnt1 == N1 )
            begin
                cnt1 <= 0;
                cnt2 <= cnt2 + 1;
            end
            else
                cnt1 <= cnt1 + 1;
                
            if( cnt2 == N2 && cnt1 == N1)
            begin
                cnt2 <= 0;
                cnt3 <= cnt3 + 1;
            end
            
            if( cnt3 == N1 && cnt2 == N2 && cnt1 == N1 )
            begin
                cnt3 <= 0;
                cnt4 <= cnt4 + 1;
            end
            
            if( cnt4 == N2 && cnt3 == N1 && cnt2 == N2 && cnt1 == N1)
            begin
                cnt4 <= 0;
                cnt5 <= cnt5 + 1;
            end
            
            if( cnt5 == N1 && cnt4 == N2 && cnt3 == N1 && cnt2 == N2 && cnt1 == N1)
            begin
                cnt5 <= 0;
                cnt6 <= cnt6 + 1;
            end
            
            if(cnt6 == N3 && cnt5 == N4 && cnt4 == N2 && cnt3 == N1 && cnt2 == N2 && cnt1 == N1)
            begin
                cnt1 <= 0;
                cnt2 <= 0;
                cnt3 <= 0;
                cnt4 <= 0;
                cnt5 <= 0;
                cnt6 <= 0;
            end
        end
    end
    
    //这是设置闹钟的时分秒的芯片
    always @(posedge one_second_clk)
        begin
            if( alarm_clock_mode == 1 && set == 1 )
            begin
                if( add == 1 )
                begin
                    if( select == 0 )
                    begin
                        if(alarm_clock_cnt1 == N1)
                            alarm_clock_cnt1 <= 0;
                        else    
                            alarm_clock_cnt1 <= alarm_clock_cnt1 + 1;
                    end
                    
                    else if( select == 1 )
                    begin
                        if( alarm_clock_cnt2 == N2 )
                            alarm_clock_cnt2 <= 0;
                        else
                            alarm_clock_cnt2 <= alarm_clock_cnt2 + 1;
                    end
                    
                    else if( select == 2 )
                    begin
                        if( alarm_clock_cnt3 == N1 )
                            alarm_clock_cnt3 <= 0;
                        else
                            alarm_clock_cnt3 <= alarm_clock_cnt3 + 1;
                    end
                    
                    else if( select == 3 )
                    begin
                        if( alarm_clock_cnt4 == N2 )
                            alarm_clock_cnt4 <= 0;
                        else
                            alarm_clock_cnt4 <= alarm_clock_cnt4 + 1;
                    end
                    
                    else if( select == 4 )
                    begin
                        if( alarm_clock_cnt5 == N1 )
                            alarm_clock_cnt5 <= 0;
                        else
                            alarm_clock_cnt5 <= alarm_clock_cnt5 + 1;
                    end
                    
                    else if( select == 5 )
                    begin
                        if( alarm_clock_cnt6 == N3 )
                            alarm_clock_cnt6 <= 0;
                        else
                            alarm_clock_cnt6 <= alarm_clock_cnt6 + 1;
                    end 
                end
            end
            
            else if( alarm_clock_mode == 0 )
            begin
                alarm_clock_cnt1 <= 0;
                alarm_clock_cnt2 <= 0;
                alarm_clock_cnt3 <= 0;
                alarm_clock_cnt4 <= 0;
                alarm_clock_cnt5 <= 0;
                alarm_clock_cnt6 <= 0;
            end
        end
        

    //这是LED模块，LED会在两个时间会点亮，第一是在设置时间的时候，提示用户，现在设置的是哪一位，L0对应时钟的十位，以此类推，一直到L5对应秒针的个位；
    //第二就是当闹钟到时间的时候，全部LED灯会进行一个来回的闪烁，用状态机控制
    always @(*)
    begin
        if( set ==1 )
        begin
            case(select)
                3'b101:
                    begin
                        L0 <= 1; L1 <= 0; L2 <= 0; L3 <= 0; L4 <= 0; L5 <= 0; L6 <= 0; L7 <= 0; 
                        L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 0;
                    end 
                3'b100:
                    begin
                        L0 <= 0; L1 <= 1; L2 <= 0; L3 <= 0; L4 <= 0; L5 <= 0; L6 <= 0; L7 <= 0; 
                        L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 0;
                    end 
                3'b011:
                    begin
                        L0 <= 0; L1 <= 0; L2 <= 1; L3 <= 0; L4 <= 0; L5 <= 0; L6 <= 0; L7 <= 0; 
                        L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 0;                       
                    end
                3'b010:
                    begin
                        L0 <= 0; L1 <= 0; L2 <= 0; L3 <= 1; L4 <= 0; L5 <= 0; L6 <= 0; L7 <= 0; 
                        L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 0;
                     end
                3'b001:
                    begin
                        L0 <= 0; L1 <= 0; L2 <= 0; L3 <= 0; L4 <= 1; L5 <= 0; L6 <= 0; L7 <= 0; 
                        L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 0;
                    end                 
                3'b000:
                    begin
                        L0 <= 0; L1 <= 0; L2 <= 0; L3 <= 0; L4 <= 0; L5 <= 1; L6 <= 0; L7 <= 0; 
                        L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 0;
                    end 
                default:
                    begin
                        L0 <= 0; L1 <= 0; L2 <= 0; L3 <= 0; L4 <= 0; L5 <= 0; L6 <= 0; L7 <= 0; 
                        L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 0;
                    end                
            endcase
        end
        
        if( set == 0 )
        begin
            if( alarm_clock_arrive_time == 1 && flag == 1)
            begin
                case(s)
                    0:begin
                        L0 <= 1; L1 <= 0; L2 <= 0; L3 <= 0; L4 <= 0; L5 <= 0; L6 <= 0; L7 <= 0; 
                        L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 1;
                      end
                    1:begin
                        L0 <= 0; L1 <= 1; L2 <= 0; L3 <= 0; L4 <= 0; L5 <= 0; L6 <= 0; L7 <= 0; 
                        L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 1; L15 <= 0;
                      end               
                    2:begin
                        L0 <= 0; L1 <= 0; L2 <= 1; L3 <= 0; L4 <= 0; L5 <= 0; L6 <= 0; L7 <= 0; 
                        L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 1; L14 <= 0; L15 <= 0;
                      end
                    3:begin
                        L0 <= 0; L1 <= 0; L2 <= 0; L3 <= 1; L4 <= 0; L5 <= 0; L6 <= 0; L7 <= 0; 
                        L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 1; L13 <= 0; L14 <= 0; L15 <= 0;
                      end
                    4:begin
                        L0 <= 0; L1 <= 0; L2 <= 0; L3 <= 0; L4 <= 1; L5 <= 0; L6 <= 0; L7 <= 0; 
                        L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 1; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 0;
                      end
                    5:begin
                        L0 <= 0; L1 <= 0; L2 <= 0; L3 <= 0; L4 <= 0; L5 <= 1; L6 <= 0; L7 <= 0; 
                        L8 <= 0; L9 <= 0; L10 <= 1; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 0;
                      end
                    6:begin
                        L0 <= 0; L1 <= 0; L2 <= 0; L3 <= 0; L4 <= 0; L5 <= 0; L6 <= 1; L7 <= 0; 
                        L8 <= 0; L9 <= 1; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 0;
                      end
                    7:begin
                        L0 <= 0; L1 <= 0; L2 <= 0; L3 <= 0; L4 <= 0; L5 <= 0; L6 <= 0; L7 <= 1; 
                        L8 <= 1; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 0;
                      end
                    default:begin
                                L0 <= 0; L1 <= 0; L2 <= 0; L3 <= 0; L4 <= 0; L5 <= 0; L6 <= 0; L7 <= 0; 
                                L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 0;
                            end
                endcase
            end
            
            else
            begin
                L0 <= 0; L1 <= 0; L2 <= 0; L3 <= 0; L4 <= 0; L5 <= 0; L6 <= 0; L7 <= 0; 
                L8 <= 0; L9 <= 0; L10 <= 0; L11 <= 0; L12 <= 0; L13 <= 0; L14 <= 0; L15 <= 0;
            end
        end        
    end
    


    //LED灯光闪烁状态机的状态切换
    always @( posedge clk_10Hz )
    begin
        s <= s + 1;
    end


    //这是按下carryOut按钮实现进位的芯片
    always @(posedge one_second_clk)
    begin
        if( carry == 1 && set == 1 )
        begin
            if( select == N2 )
                select <= 3'b000;
            else
                select <= select + 1;
        end
        else if( set == 0 )
            select <= 3'b000;
         
    end   
    
    
  
    
    //这是判断闹钟到时间没有的芯片
    always @(*)
    begin
        if( alarm_clock_mode == 1 )
        begin
            if( alarm_clock_cnt6 > cnt6 )
                alarm_clock_arrive_time <= 1;
            else if(alarm_clock_cnt6 < cnt6 )
                alarm_clock_arrive_time <= 0;
            else if(alarm_clock_cnt6 == cnt6)
            begin
                if( alarm_clock_cnt5 > cnt5 )
                    alarm_clock_arrive_time <= 1;
                else if(alarm_clock_cnt5 < cnt5 )
                    alarm_clock_arrive_time <= 0;
                else if(alarm_clock_cnt5 == cnt5)
                begin
                    if( alarm_clock_cnt4 > cnt4 )
                        alarm_clock_arrive_time <= 1;
                    else if(alarm_clock_cnt4 < cnt4 )
                        alarm_clock_arrive_time <= 0;
                    else if(alarm_clock_cnt4 == cnt4)
                    begin
                        if( alarm_clock_cnt3 > cnt3 )
                            alarm_clock_arrive_time <= 1;
                        else if(alarm_clock_cnt3 < cnt3 )
                            alarm_clock_arrive_time <= 0;
                        else if(alarm_clock_cnt3 == cnt3)
                        begin
                            if( alarm_clock_cnt2 > cnt2 )
                                alarm_clock_arrive_time <= 1;
                            else if(alarm_clock_cnt2 < cnt2 )
                                alarm_clock_arrive_time <= 0;
                            else if(alarm_clock_cnt2 == cnt2)
                            begin
                                if( alarm_clock_cnt1 > cnt1 || alarm_clock_cnt1 == cnt1)
                                    alarm_clock_arrive_time <= 1;
                                else if(alarm_clock_cnt1 < cnt1 )
                                    alarm_clock_arrive_time <= 0;              
                            end
                        end
                    end
                end
            end
            
        end
        else
            alarm_clock_arrive_time <= 0;
    end
    

    //这是数码管需要显示什么数字的芯片，根据shift和是否是闹钟模式来判断，如果是闹钟正在设置，那就显示设置的时间，其他情况一律显示当前时间
    always @(*)
    begin
        if(shift == 0)
        begin
            if( alarm_clock_mode == 0 || ( alarm_clock_mode == 1 && set == 0 ) )
            begin
               x[3:0] <= cnt1;
                x[7:4] <= cnt2;
                x[11:8] <= cnt3;
                x[15:12] <= cnt4;
            end
                
            else if( alarm_clock_mode == 1 && set == 1 ) 
            begin
                x[3:0] <= alarm_clock_cnt1;
                x[7:4] <= alarm_clock_cnt2;
                x[11:8] <= alarm_clock_cnt3;
                x[15:12] <= alarm_clock_cnt4;
            end
        end
        
        else
        begin
            if( alarm_clock_mode == 0 || ( alarm_clock_mode == 1 && set == 0 ) )
            begin
                x[3:0] <= cnt3;
                x[7:4] <= cnt4;
                x[11:8] <= cnt5;
                x[15:12] <= cnt6; 
            end
            
            else if( alarm_clock_mode == 1 && set == 1 )
            begin
                x[3:0] <= alarm_clock_cnt3;
                x[7:4] <= alarm_clock_cnt4;
                x[11:8] <= alarm_clock_cnt5;
                x[15:12] <= alarm_clock_cnt6;
            end
            
        end
    end
    
endmodule
    

//这是一个计数器的模快，或者说是秒表吧
module counter #(parameter N1 = 9, N2 = 5) (
    input wire clk_10Hz,
    input wire clk_25mhz,
    input wire clk_60Hz,
    input wire clr,
    input wire shift,
    input wire pause,
    output reg [15:0] x
    );
    
    reg [3:0] cnt1;//毫秒针个位计数器
    reg [3:0] cnt2;//毫秒针十位计数器
    reg [3:0] cnt3;//秒针个位计数器
    reg [3:0] cnt4;//秒针十位计数器
    reg [3:0] cnt5;//分针个位计数器
    reg [3:0] cnt6;//分针十位计数器
    reg p = 1,cl = 1;
    wire pau;
    
    

    button pb(.button_in(pause), .clk(clk_25mhz), .button_out(pau));
    
    
    always @( posedge clk_60Hz or posedge clr )
    begin
        if( clr == 1 || cl == 1 )
        begin
            cnt1 <= 0;
            cnt2 <= 0;
            cnt3 <= 0;
            cnt4 <= 0;
            cnt5 <= 0;
            cnt6 <= 0;
        end
        
        else if( cl == 0 && p == 0 )
        begin
            if( cnt1 == N1 )
            begin
                cnt1 <= 0;
                cnt2 <= cnt2 + 1;
            end
            else
                cnt1 <= cnt1 + 1;
                
            if( cnt2 == N2 && cnt1 == N1)
            begin
                cnt2 <= 0;
                cnt3 <= cnt3 + 1;
            end
            
            if( cnt3 == N1 && cnt2 == N2 && cnt1 == N1 )
            begin
                cnt3 <= 0;
                cnt4 <= cnt4 + 1;
            end
            
            if( cnt4 == N2 && cnt3 == N1 && cnt2 == N2 && cnt1 == N1 )
            begin
                cnt4 <= 0;
                cnt5 <= cnt5 + 1;
            end
                        
            if( cnt5 == N1 && cnt4 == N2 && cnt3 == N1 && cnt2 == N2 && cnt1 == N1 )
            begin
                cnt5 <= 0;
                cnt6 <= cnt6 + 1;
            end
                                    
            if( cnt6 == N2 && cnt5 == N1 && cnt4 == N2 && cnt3 == N1 && cnt2 == N2 && cnt1 == N1)
            begin
                cnt1 <= 0;
                cnt2 <= 0;
                cnt3 <= 0;
                cnt4 <= 0;
                cnt5 <= 0;
                cnt6 <= 0;
            end
        end
    end
     
    always @(posedge clk_10Hz or posedge clr)
    begin
        if(clr == 1 )
            cl <= 1;
            
        else if(pau == 1)
        begin
            p <= ~p;
            cl <= 0;
        end
        
    end
      
    

    
    always @(*)
        begin
            if(shift == 0)
            begin
                 x[3:0] <= cnt1;
                 x[7:4] <= cnt2;
                 x[11:8] <= cnt3;
                 x[15:12] <= cnt4;
            end
            
            else
            begin
                x[3:0] <= cnt3;
                 x[7:4] <= cnt4;
                 x[11:8] <= cnt5;
                 x[15:12] <= cnt6;
            end
        end
    
endmodule
            
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
    reg [19:0] clkdiv=0;
    parameter T=50000;
    
    assign dp = 1;
    assign enable = 4'b1111;


    always @(posedge clk)
    begin
            clkdiv <= clkdiv + 1;
            if( clkdiv == T )
            begin 
                clkdiv <= 0;
                s <= s + 1;
                if( s == 4 )
                    s <= 0;
            end
        end
    
    always @( * )   
        case(s)
            0: number = x[3:0];
            1: number = x[7:4];
            2: number = x[11:8];
            3: number = x[15:12];
            default: number = x[3:0];
        endcase


    always @( posedge clk)
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
            'hA: a_to_g = 7'b0000001;
            'hB: a_to_g = 7'b0000001;
            'hC: a_to_g = 7'b0000001;
            'hD: a_to_g = 7'b0000001;
            'hE: a_to_g = 7'b0000001;
            'hF: a_to_g = 7'b0000001;
            default: a_to_g = 7'b0000001;
        endcase
    

    
endmodule    






module counter_top(
    input clk,
    input clr,
    input set,
    input shift,
    input addOne,
    input carryOut,
    input pause,
    input choice,
    input alarm_clock_mode,
    output [3:0] an,
    output [6:0] a_to_g,
    output dp,
    output  L0,
    output  L1,
    output  L2,
    output  L3,
    output  L4,
    output  L5,
    output  L6,
    output  L7,
    output  L8,
    output  L9,
    output  L10,
    output  L11,
    output  L12,
    output  L13,
    output  L14,
    output  L15
    );

    wire clk_1Hz,clk_10Hz,clk_60Hz,clk_25mhz;
    wire [15:0] cnter ;
    wire [15:0] clock ;
    reg [15:0] x;

    one_second os(.clk(clk), .clr(clr), .one_second_clk(clk_1Hz));
    ten_Hz ten(.clk(clk), .clr(clr), .ten_Hz_clk(clk_10Hz));                                                        
    sixty_Hz sixty(.clk(clk), .clr(clr), .sixty_Hz_clk(clk_60Hz));
    twentyfiveMhz twentyfive(.clk(clk), .clr(clr), .clk_25mhz(clk_25mhz));
    
    counter cnt(.clk_10Hz(clk_10Hz), .clk_25mhz(clk_25mhz), .clk_60Hz(clk_60Hz), .clr(clr), .shift(shift), .pause(pause), .x(cnter));
     
    electronic_clock c(.one_second_clk(clk_1Hz), .clk_10Hz(clk_10Hz), .clk_25mhz(clk_25mhz), .alarm_clock_mode(alarm_clock_mode), .set(set), .shift(shift), .addOne(addOne), .carryOut(carryOut), .x(clock), .L0(L0), .L1(L1), .L2(L2), .L3(L3), .L4(L4), .L5(L5), .L6(L6), .L7(L7), .L8(L8), .L9(L9), .L10(L10), .L11(L11), .L12(L12), .L13(L13), .L14(L14), .L15(L15));
    
    always @(*)
    begin
        if( choice == 1 )
            x <= cnter;
        else
            x <= clock;
    end
    
    seg7 s(.x(x), .clk(clk), .clr(clr), .an(an), .a_to_g(a_to_g), .dp(dp));
endmodule
