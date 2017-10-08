`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 16:01:21
// Design Name: 
// Module Name: Register
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


module Register(
    input clk,
    input RegWre,
    input [4:0] RD_reg1_addr,
    input [4:0] RD_reg2_addr,
    input [4:0] WR_reg_addr,
    input [31:0] WR_data,
    output reg [31:0] RD_data1,
    output reg [31:0] RD_data2
    );
    
    reg [31:0] registers [31:0];
    
    initial begin
        registers[0] = 4'h00000000;
    end
    
    always@ (*) begin // read 
        RD_data1 = registers[RD_reg1_addr];
        RD_data2 = registers[RD_reg2_addr];
    end
    
    always@ (negedge clk) begin
        if( RegWre == 1 && WR_reg_addr != 0)
            registers[WR_reg_addr] = WR_data;
    end 
    
endmodule
