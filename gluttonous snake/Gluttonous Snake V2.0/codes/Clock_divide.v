`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/23 20:47:06
// Design Name: 
// Module Name: Clock_divide
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


module Clock_divide(
    input wire clk,
    output wire clk_25MHz,
    output wire clk_50MHz,
    output wire clk_100Hz, //119Hz
    output wire clk_4Hz //3.7Hz has changed
    );
    
    reg [28:0]clkdiv;
    //reg [30:0]clkdv_2;
    
    initial begin
        clkdiv <= 0;
        //clkdiv_2 <= 0;
        //clk_2Hz <= 0;
    end
    
    assign clk_50MHz = clkdiv[0];
    assign clk_25MHz = clkdiv[1];
    assign clk_100Hz = clkdiv[20];
    assign clk_4Hz = clkdiv[25];   
    
    always @ (posedge clk)
        begin
            clkdiv <= clkdiv + 1;
        end
    /*
    always @ (posedge clk)
        begin
            if(clkdiv_2 <= 499999999) begin
                clkdiv_2 <= 0;
                clk_4Hz <= clk_4Hz + 1;
            end
            if(clkdiv_2 <= 250000000) begin
                clkdiv_2 <= clkdiv + 1;
                clk_4Hz <= clk_4Hz + 1;
            end
            else clkdiv_2 <= clkdiv + 1;
        end
    */
endmodule
