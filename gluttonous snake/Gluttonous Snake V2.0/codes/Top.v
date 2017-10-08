`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/24 02:35:41
// Design Name: 
// Module Name: Top
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


module Top(
    input wire main_clk, //主时钟 100MHz
    input wire [4:0] button_in_, //五颗按钮：中、上、下、左、右
    output wire [6:0] a_to_g_, //七段管
    output wire [1:0] an_, //七段管
    output wire VGA_HS_,//行同步信号       
    output wire VGA_VS_,//场同步信号       
    output wire [3:0] VGA_R_,        
    output wire [3:0] VGA_G_,        
    output wire [3:0] VGA_B_
    );
    
    wire clk_25MHz_;
    wire clk_50MHz_;
    wire clk_4Hz_;
    wire clk_100Hz_;
    
    wire [1:0] mode_;
    wire [3:0] score_;
    wire middle_;
    wire up_;
    wire down_;
    wire left_;
    wire right_;
    
    wire [39:0] VRAM_; //行显存
    wire [5:0] y_pos_; //行指针
    wire [5:0] apple_x_;
    wire [5:0] apple_y_;
    wire [5:0] head_x_;
    wire [5:0] head_y_;
    //wire [5:0] node_cube_x_;
    //wire [5:0] node_cube_y_;
    //wire [3:0] node_;
    
    wire eat;
    
    
    Clock_divide clock(
        .clk( main_clk ), //100MHz
        .clk_25MHz( clk_25MHz_ ),
        .clk_50MHz( clk_50MHz_ ),
        .clk_100Hz( clk_100Hz_ ),
        .clk_4Hz( clk_4Hz_ )
    );
    
    Button_Scaning Button(
        .clk( clk_25MHz_ ), //25MHz              
        .button_in( button_in_ ),//    
        .middle( middle_ ), //0,消抖后的按键       
        .up( up_ ), //1                  
        .down( down_ ),//2                 
        .left( left_ ),//3                 
        .right( right_ )//4                 
    );
    
    Game_Control Game(
        .mode( mode_ ), //输出游戏状态
        .score( score_ ), //传入游戏分数
        .middle_set( middle_ ) //开始游戏
    );
    
    
    
    Display Display_(
        .clk_100Hz( clk_100Hz_ ), //用于七段管扫描 
        .clk_50MHz( clk_50MHz_ ),
        .score( score_ ), //传入游戏分数
        /*
        .y_pos( y_pos_ ), //传入行指针
        .node_cube_x( node_cube_x_ ), //传入蛇身节点x坐标
        .node_cube_y( node_cube_y_ ), //传入蛇身节点y坐标
        .node( node_ ), //传出蛇身节点位置
        .apple_x( apple_x_ ),//传入苹果x坐标 
        .apple_y( apple_y_ ),//传入苹果y坐标                        
        .Line_VRAM( VRAM_ ), //传出行显存
        */
        .a_to_g ( a_to_g_ ),  
        .an ( an_ )                   
    );
    
    vga_controller VGA(
        .clk_25MHz( clk_25MHz_ ), //25MHz                                                        
        .rst_n(  ), //复位信号，rst_n == 1时画面全黑                                             
        .VRAM( VRAM_ ), //从另一个模块传过来的图像信息, 每2bits记录一个坐标的色彩信息                          
        .y_pos( y_pos_ ), //行信号传给Display模块                                             
        .VGA_HS( VGA_HS_ ),//行同步信号                                                            
        .VGA_VS( VGA_VS_ ),//场同步信号                                                            
        .VGA_R( VGA_R_ ),                                                      
        .VGA_G( VGA_G_ ),                                                             
        .VGA_B( VGA_B_ )                                                              
    );
    
    
    
    
    Snake_Control Snake(
        .clk_4Hz( clk_4Hz_ ),                                                                        
        .mode( mode_ ), // 传入游戏状态                                                 
        .up( up_ ),                                                            
        .down( down_ ),                                                                           
        .right( right_ ),                                                                          
        .left( left_ ), // 四个按钮状态                                                                           
        .apple_x( apple_x_ ),  //传入苹果x坐标                                                                 
        .apple_y( apple_y_ ),  //传入苹果y坐标
        .eat(eat),
        .node( node_ ),  //传入蛇身节点位置
        .cubenum( score_ ),//得分，最大15                                                         
        .head_x( head_x_ ), //传出蛇头x坐标                                                                
        .head_y( head_y_ ), //传出蛇头y坐标
        .y_pos( y_pos_ ),     
        .SNAKE_VRAM ( VRAM_ )
        //.node_cube_x( node_cube_x_ ),  //传出蛇身节点x坐标
        //.node_cube_y( node_cube_y_ )   //传出蛇身节点y坐标                                                      
    );
    
    Eating_Apple Apple(
        .clk_50MHz( clk_50MHz_ ),    
        .mode( mode_ ), //传入游戏状态
        .head_x( head_x_ ),  //传入蛇头x坐标
        .head_y( head_y_ ),  //传入蛇头y坐标
        .apple_x( apple_x_ ),  //传出苹果x坐标
        .apple_y( apple_y_ ),   //传出苹果y坐标
        .eat_(eat)
    );
    
endmodule
