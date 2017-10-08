`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 16:40:51
// Design Name: 
// Module Name: DataMemory
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

//读就直接读，写就在下降沿写
module DataMemory(
    input clk,
    input [31:0] data_addr,
    input [31:0] data_in,
    input DataMemRW, //1写，0读
    output reg [31:0] memory_out
    );
    
    reg [7:0] data [255:0];
    
    
    always@ (negedge clk) begin // write
        if(DataMemRW == 1) begin
            data[data_addr] = data_in[31:24];
            data[data_addr + 1] = data_in[23:16];
            data[data_addr + 2] = data_in[15:8];
            data[data_addr + 3] = data_in[7:0];
        end
    end
    
    always@ (*) begin // read
        if(DataMemRW == 0) 
            memory_out = {data[data_addr], data[data_addr + 1],
             data[data_addr + 2], data[data_addr + 3]};
    end
    
endmodule
