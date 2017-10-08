`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/16 13:59:07
// Design Name: 
// Module Name: Mux_WRdataSrc
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


module Mux_WRdataSrc(
    input WRRegDSrc,
    input [31:0] DBDR_out,
    input [31:0] PC,
    output reg [31:0] WR_data
    );
    
    always@ (*) begin
        if(WRRegDSrc == 0)
            WR_data = PC + 4;
        else
            WR_data = DBDR_out;
    end

endmodule
