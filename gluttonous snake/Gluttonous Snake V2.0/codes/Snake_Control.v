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

module Snake_Control(
         input wire clk_4Hz,
         input wire [1:0] mode,
         input wire up,
         input wire down,
         input wire right,
         input wire left,
         input wire [5:0] apple_x,
         input wire [5:0] apple_y,
         input wire eat,
         
         input wire [3:0] node, //从display模块传过来的蛇节点位置
         
         //output reg [35:0] zhuanwan,//记录转弯钱  蛇的第二个位置  只记录蛇头不能判断方向
         output reg [3:0] cubenum,//得分，最大15 
         output wire [5:0] head_x,
         output wire [5:0] head_y,
         
         input wire [5:0] y_pos,
         output reg [39:0] SNAKE_VRAM
         //output reg [5:0] node_cube_y
         
	 // output reg apple_status
    );
    reg  status;
    reg [1:0] direct;//现在正在运动的方向 
    reg [5:0] cube_x[15:0];
    reg [5:0] cube_y[15:0];
    wire plus;
    
    assign plus = ( status | eat );
    assign head_x = cube_x[0];
    assign head_y = cube_y[0];
    
    parameter UP = 0;
    parameter DOWN = 1;
    parameter LEFT = 2;
    parameter RIGHT = 3;
//reg change_to_left,change_to_right,change_to_up,change_to_down;
    
    /*
    always @ ( * ) begin
        case(node)
            0: begin  node_cube_x <= cube_x[0]; node_cube_y <= cube_y[0]; end
            1: begin  node_cube_x <= cube_x[1]; node_cube_y <= cube_y[1]; end
            2: begin  node_cube_x <= cube_x[2]; node_cube_y <= cube_y[2]; end
            3: begin  node_cube_x <= cube_x[3]; node_cube_y <= cube_y[3]; end
            4: begin  node_cube_x <= cube_x[4]; node_cube_y <= cube_y[4]; end
            5: begin  node_cube_x <= cube_x[5]; node_cube_y <= cube_y[5]; end
            6: begin  node_cube_x <= cube_x[6]; node_cube_y <= cube_y[6]; end
            7: begin  node_cube_x <= cube_x[7]; node_cube_y <= cube_y[7]; end
            8: begin  node_cube_x <= cube_x[8]; node_cube_y <= cube_y[8]; end
            9: begin  node_cube_x <= cube_x[9]; node_cube_y <= cube_y[9]; end
            10: begin  node_cube_x <= cube_x[10]; node_cube_y <= cube_y[10]; end
            11: begin  node_cube_x <= cube_x[11]; node_cube_y <= cube_y[11]; end
            12: begin  node_cube_x <= cube_x[12]; node_cube_y <= cube_y[12]; end
            13: begin  node_cube_x <= cube_x[13]; node_cube_y <= cube_y[13]; end
            14: begin  node_cube_x <= cube_x[14]; node_cube_y <= cube_y[14]; end
            15: begin  node_cube_x <= cube_x[15]; node_cube_y <= cube_y[15]; end
            default : begin  node_cube_x <= cube_x[0]; node_cube_y <= cube_y[0]; end
        endcase
    end
    */
    
    always @ ( * ) begin
    
        SNAKE_VRAM <= 0;
        
        if(apple_y == y_pos) SNAKE_VRAM[apple_x] <= 1;
        if(cube_y[0] == y_pos) SNAKE_VRAM[cube_x[0]] <= 1;
        if(cube_y[1] == y_pos) SNAKE_VRAM[cube_x[1]] <= 1;
        if(cube_y[2] == y_pos) SNAKE_VRAM[cube_x[2]] <= 1;
        if(cube_y[3] == y_pos && 0 < cubenum) SNAKE_VRAM[cube_x[3]] <= 1;
        if(cube_y[4] == y_pos && 1 < cubenum) SNAKE_VRAM[cube_x[4]] <= 1;
        if(cube_y[5] == y_pos && 2 < cubenum) SNAKE_VRAM[cube_x[5]] <= 1;
        if(cube_y[6] == y_pos && 3 < cubenum) SNAKE_VRAM[cube_x[6]] <= 1;
        if(cube_y[7] == y_pos && 4 < cubenum) SNAKE_VRAM[cube_x[7]] <= 1;
        if(cube_y[8] == y_pos && 5 < cubenum) SNAKE_VRAM[cube_x[8]] <= 1;
        if(cube_y[9] == y_pos && 6 < cubenum) SNAKE_VRAM[cube_x[9]] <= 1;
        if(cube_y[10] == y_pos && 7 < cubenum) SNAKE_VRAM[cube_x[10]] <= 1;    
        if(cube_y[11] == y_pos && 8 < cubenum) SNAKE_VRAM[cube_x[11]] <= 1;
        if(cube_y[12] == y_pos && 9 < cubenum) SNAKE_VRAM[cube_x[12]] <= 1;
        if(cube_y[13] == y_pos && 10 < cubenum) SNAKE_VRAM[cube_x[13]] <= 1;
        if(cube_y[14] == y_pos && 11 < cubenum) SNAKE_VRAM[cube_x[14]] <= 1;
        if(cube_y[15] == y_pos && 12 < cubenum) SNAKE_VRAM[cube_x[15]] <= 1;
        
    end

   initial
        begin
            cube_x[0] <= 20;
            cube_y[0] <= 15;
            
            cube_x[1] <= 20;
            cube_y[1] <= 14;
            
            cube_x[2] <= 20;
            cube_y[2] <= 13;
        
            cube_x[3] <= 0;
            cube_y[3] <= 0;
            
            cube_x[4] <= 0;
            cube_y[4] <= 0;
            
            cube_x[5] <= 0;
            cube_y[5] <= 0;
            
            cube_x[6] <= 0;
            cube_y[6] <= 0;
            
            cube_x[7] <= 0;
            cube_y[7] <= 0;
            
            cube_x[8] <= 0;
            cube_y[8] <= 0;
            
            cube_x[9] <= 0;
            cube_y[9] <= 0;
            
            cube_x[10] <= 0;
            cube_y[10] <= 0;
            
            cube_x[11] <= 0;
            cube_y[11] <= 0;
            
            cube_x[12] <= 0;
            cube_y[12] <= 0;
            
            cube_x[13] <= 0;
            cube_y[13] <= 0;
            
            cube_x[14] <= 0;
            cube_y[14] <= 0;
            
            cube_x[15] <= 0;
            cube_y[15] <= 0;
        
            //zhuanwan <= 0;
            
            cubenum<=0;//吃的苹果数量
            direct<=DOWN;
            status <= 0;
           
        end

   wire button_plus;
   assign button_plus = ( up | down | left | right );

    always @ ( posedge button_plus ) //修改蛇头运动方向
        begin
            if( up == 1 ) 
            begin
            if( direct != UP && direct != DOWN)
                direct <= UP;
            end
            if( down == 1)
            begin
            if( direct != UP && direct != DOWN)
                direct <= DOWN;
            end
            if( left == 1)
            begin
            if( direct != LEFT && direct != RIGHT)
                direct <= LEFT;
            end
            if( right == 1) 
            begin
            if( direct != LEFT && direct != RIGHT)
                direct <= RIGHT;
            end
            if(mode != 1) direct <= DOWN;    
            
        end

always@(posedge clk_4Hz)
    begin
          if( mode!=1 )
               begin
                cube_x[0] <= 20;
                cube_y[0] <= 15;
                
                cube_x[1] <= 20;
                cube_y[1] <= 14;
                
                cube_x[2] <= 20;
                cube_y[2] <= 13;
            
                cube_x[3] <= 0;
                cube_y[3] <= 0;
                
                cube_x[4] <= 0;
                cube_y[4] <= 0;
                
                cube_x[5] <= 0;
                cube_y[5] <= 0;
                
                cube_x[6] <= 0;
                cube_y[6] <= 0;
                
                cube_x[7] <= 0;
                cube_y[7] <= 0;
                
                cube_x[8] <= 0;
                cube_y[8] <= 0;
                
                cube_x[9] <= 0;
                cube_y[9] <= 0;
                
                cube_x[10] <= 0;
                cube_y[10] <= 0;
                
                cube_x[11] <= 0;
                cube_y[11] <= 0;
                
                cube_x[12] <= 0;
                cube_y[12] <= 0;
                
                cube_x[13] <= 0;
                cube_y[13] <= 0;
                
                cube_x[14] <= 0;
                cube_y[14] <= 0;
                
                cube_x[15] <= 0;
                cube_y[15] <= 0;
            
                //zhuanwan <= 0;
//                cubenum<=0;//吃的苹果数量
               
          end
        if( mode==1 )
            begin
                  /**************************************************///判断出界
                  //撞墙 
                  if((direct == UP && cube_y[0] == 1) | (direct==DOWN && cube_y[0] ==  28) | (direct==LEFT && cube_x[0] == 1) | (direct==RIGHT && cube_x[0] == 38))
                        status <= 1;
                   //撞自己 
                   else if((cube_y[0]==cube_y[1]&&cube_x[0]==cube_x[1])|
                            (cube_y[0]==cube_y[2]&&cube_x[0]==cube_x[2])|
                            (cube_y[0]==cube_y[3]&&cube_x[0]==cube_x[3]&&cubenum>0)|
                            (cube_y[0]==cube_y[4]&&cube_x[0]==cube_x[4]&&cubenum>1)|
                            (cube_y[0]==cube_y[5]&&cube_x[0]==cube_x[5]&&cubenum>2)|
                            (cube_y[0]==cube_y[6]&&cube_x[0]==cube_x[6]&&cubenum>3)|
                            (cube_y[0]==cube_y[7]&&cube_x[0]==cube_x[7]&&cubenum>4)|
                            (cube_y[0]==cube_y[8]&&cube_x[0]==cube_x[8]&&cubenum>5)|
                            (cube_y[0]==cube_y[9]&&cube_x[0]==cube_x[9]&&cubenum>6)|
                            (cube_y[0]==cube_y[10]&&cube_x[0]==cube_x[10]&&cubenum>7)|
                            (cube_y[0]==cube_y[11]&&cube_x[0]==cube_x[11]&&cubenum>8)|
                            (cube_y[0]==cube_y[12]&&cube_x[0]==cube_x[12]&&cubenum>9)|
                            (cube_y[0]==cube_y[13]&&cube_x[0]==cube_x[13]&&cubenum>10)|
                            (cube_y[0]==cube_y[14]&&cube_x[0]==cube_x[14]&&cubenum>11)|
                            (cube_y[0]==cube_y[15]&&cube_x[0]==cube_x[15]&&cubenum>12))
                                  status <= 1;
                   //正常情况下
                   else 
                       begin
                            status <= 0;
                            cube_x[1]<=cube_x[0];
                            cube_y[1]<=cube_y[0];
                            
                            cube_x[2]<=cube_x[1];
                            cube_y[2]<=cube_y[1];
                            
                            cube_x[3]<=cube_x[2];
                            cube_y[3]<=cube_y[2];
                            
                            cube_x[4]<=cube_x[3];
                            cube_y[4]<=cube_y[3];
                            
                            cube_x[5]<=cube_x[4];
                            cube_y[5]<=cube_y[4];
                            
                            cube_x[6]<=cube_x[5];
                            cube_y[6]<=cube_y[5];
                            
                            cube_x[7]<=cube_x[6];
                            cube_y[7]<=cube_y[6];
                            
                            cube_x[8]<=cube_x[7];
                            cube_y[8]<=cube_y[7];
                            
                            cube_x[9]<=cube_x[8];
                            cube_y[9]<=cube_y[8];
                            
                            cube_x[10]<=cube_x[9];
                            cube_y[10]<=cube_y[9];
                            
                            cube_x[11]<=cube_x[10];
                            cube_y[11]<=cube_y[10];
                            
                            cube_x[12]<=cube_x[11];
                            cube_y[12]<=cube_y[11];
                            
                            cube_x[13]<=cube_x[12];
                            cube_y[13]<=cube_y[12];
                            
                            cube_x[14]<=cube_x[13];
                            cube_y[14]<=cube_y[13];
                            
                            cube_x[15]<=cube_x[14];
                            cube_y[15]<=cube_y[14];
                            
                            
                            case(direct)   //移动蛇头
                            UP:
                                 cube_y[0] <= cube_y[0] - 1;
                            DOWN:
                                 cube_y[0] <= cube_y[0] + 1;
                            LEFT:
                                 cube_x[0] <= cube_x[0] - 1;
                            RIGHT:
                                 cube_x[0] <= cube_x[0] + 1;
                            endcase
                            
                           
                            /**************************************************///判断是否吃到苹果  
//                            if(cube_x[0] == apple_x && cube_y[0] == apple_y)
//                            begin
//                                 status <= 3;
//                            end
//                            else
//                                 status <= 0;
            
                       end 
            end
            
    end
    
    always @ ( posedge plus )
    begin
          if( status == 1)
                    cubenum <= 15;
          else if( mode != 1)
                    cubenum <= 0;
          else
              cubenum <= cubenum + 1;
    end
endmodule
