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

module Eating_Apple(
	input wire clk_50MHz,
	input wire [1:0] mode,
	//input wire apple_status,
	input wire [5:0] head_x,
	input wire [5:0] head_y,
	output reg [5:0] apple_x,
	output reg [5:0] apple_y,
	output wire eat_
);
   // reg Apple_status;
   //assign apple_status = Apple_status;
    initial
        begin
             apple_x <= 25;
             apple_y <= 15;
        end

    reg [11:0] random_num;
    reg eat;
    
    assign eat_ = eat;
    
    always @(posedge clk_50MHz)
    begin
        random_num <= random_num+927;
    end
    
    
    always @(posedge clk_50MHz)
    begin
        if(mode == 1)
        begin
            if(head_x == apple_x && head_y == apple_y ) 
                begin
                  //  Apple_status <= 0;
//                  apple_x <= 5;
//                  apple_y <= 5;
                    eat <= 1;
                    if( random_num[11:6] > 38 )
                              apple_x <= random_num[11:6] - 25;
                    else
                    begin
                     if( random_num[11:6] == 0 )
                              apple_x <= 5;
                    else
                              apple_x <= random_num[11:6];
                     end
                    if(random_num[5:0] > 28)
                              apple_y <= random_num[5:0] - 35;
                    else 
                    begin
                    if(random_num[5:0] == 0)
                              apple_y <= 8;
                    else
                              apple_y <= random_num[5:0];
                       end
//                    apple_x <= (random_num[11:6] > 38) ? (random_num[11:6] - 25) : (random_num[11:6] == 0) ? 1 : random_num[11:6];
//                   apple_y <= (random_num[5:0] > 28) ? (random_num[5:0] - 35) : ((random_num[5:0] == 0) ? 1 : random_num[5:0]);
                   // Apple_status <= 1;
                end
                else eat <= 0;
         end
        else
            begin
                 apple_x <= 25;
                 apple_y <= 15;
            end
    end
endmodule

