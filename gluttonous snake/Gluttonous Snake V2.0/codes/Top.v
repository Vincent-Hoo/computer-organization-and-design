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
    input wire main_clk, //��ʱ�� 100MHz
    input wire [4:0] button_in_, //��Ű�ť���С��ϡ��¡�����
    output wire [6:0] a_to_g_, //�߶ι�
    output wire [1:0] an_, //�߶ι�
    output wire VGA_HS_,//��ͬ���ź�       
    output wire VGA_VS_,//��ͬ���ź�       
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
    
    wire [39:0] VRAM_; //���Դ�
    wire [5:0] y_pos_; //��ָ��
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
        .middle( middle_ ), //0,������İ���       
        .up( up_ ), //1                  
        .down( down_ ),//2                 
        .left( left_ ),//3                 
        .right( right_ )//4                 
    );
    
    Game_Control Game(
        .mode( mode_ ), //�����Ϸ״̬
        .score( score_ ), //������Ϸ����
        .middle_set( middle_ ) //��ʼ��Ϸ
    );
    
    
    
    Display Display_(
        .clk_100Hz( clk_100Hz_ ), //�����߶ι�ɨ�� 
        .clk_50MHz( clk_50MHz_ ),
        .score( score_ ), //������Ϸ����
        /*
        .y_pos( y_pos_ ), //������ָ��
        .node_cube_x( node_cube_x_ ), //��������ڵ�x����
        .node_cube_y( node_cube_y_ ), //��������ڵ�y����
        .node( node_ ), //��������ڵ�λ��
        .apple_x( apple_x_ ),//����ƻ��x���� 
        .apple_y( apple_y_ ),//����ƻ��y����                        
        .Line_VRAM( VRAM_ ), //�������Դ�
        */
        .a_to_g ( a_to_g_ ),  
        .an ( an_ )                   
    );
    
    vga_controller VGA(
        .clk_25MHz( clk_25MHz_ ), //25MHz                                                        
        .rst_n(  ), //��λ�źţ�rst_n == 1ʱ����ȫ��                                             
        .VRAM( VRAM_ ), //����һ��ģ�鴫������ͼ����Ϣ, ÿ2bits��¼һ�������ɫ����Ϣ                          
        .y_pos( y_pos_ ), //���źŴ���Displayģ��                                             
        .VGA_HS( VGA_HS_ ),//��ͬ���ź�                                                            
        .VGA_VS( VGA_VS_ ),//��ͬ���ź�                                                            
        .VGA_R( VGA_R_ ),                                                      
        .VGA_G( VGA_G_ ),                                                             
        .VGA_B( VGA_B_ )                                                              
    );
    
    
    
    
    Snake_Control Snake(
        .clk_4Hz( clk_4Hz_ ),                                                                        
        .mode( mode_ ), // ������Ϸ״̬                                                 
        .up( up_ ),                                                            
        .down( down_ ),                                                                           
        .right( right_ ),                                                                          
        .left( left_ ), // �ĸ���ť״̬                                                                           
        .apple_x( apple_x_ ),  //����ƻ��x����                                                                 
        .apple_y( apple_y_ ),  //����ƻ��y����
        .eat(eat),
        .node( node_ ),  //��������ڵ�λ��
        .cubenum( score_ ),//�÷֣����15                                                         
        .head_x( head_x_ ), //������ͷx����                                                                
        .head_y( head_y_ ), //������ͷy����
        .y_pos( y_pos_ ),     
        .SNAKE_VRAM ( VRAM_ )
        //.node_cube_x( node_cube_x_ ),  //��������ڵ�x����
        //.node_cube_y( node_cube_y_ )   //��������ڵ�y����                                                      
    );
    
    Eating_Apple Apple(
        .clk_50MHz( clk_50MHz_ ),    
        .mode( mode_ ), //������Ϸ״̬
        .head_x( head_x_ ),  //������ͷx����
        .head_y( head_y_ ),  //������ͷy����
        .apple_x( apple_x_ ),  //����ƻ��x����
        .apple_y( apple_y_ ),   //����ƻ��y����
        .eat_(eat)
    );
    
endmodule
