`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 15:34:09
// Design Name: 
// Module Name: instructionMemory
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

//curPC是地址，将指令存储器地址类容读到instruction上
module instructionMemory(
    input [31:0] curPC,
    input insMemWR,
    output reg [31:0] instructionMemory_out
    );
    
    reg [7:0]  insMemory [255:0];
        
    initial begin
        $readmemb("E:/vivado_homework/MCPU/instruction.txt",insMemory);
    end
    
    always@ (*) begin
        if(insMemWR)
            instructionMemory_out = { insMemory[curPC], insMemory[curPC + 1], insMemory[curPC + 2], insMemory[curPC + 3]};
    end
    
endmodule
