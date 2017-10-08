`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 23:18:47
// Design Name: 
// Module Name: SCPU_sim
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


module SCPU_sim();
    reg clk;
    reg reset;
    wire PCWre, RegWre, insMemWR, RegDst, ExtSel, ALUSrcB, DBdataSrc, PCSrc, DataMemRW, zero;
    wire [2:0] ALUop;
    wire [5:0] op;
    wire [4:0] RD_reg1, RD_reg2, WR_reg;
    wire [31:0] curPC, nextPC, instruction, RD_data1, RD_data2, WR_data, ext_immediate, ext_immediate_shift,
                  ALU_inputA, ALU_inputB, result, memory_out;
    
    
    SCPU myCPU(
        .clk(clk),
        .reset(reset),
        .PCWre(PCWre),
        .RegWre(RegWre),
        .insMemWR(insMemWR),
        .RegDst(RegDst),
        .ExtSel(ExtSel),
        .ALUSrcB(ALUSrcB),
        .DBdataSrc(DBdataSrc),
        .PCSrc(PCSrc),
        .DataMemRW(DataMemRW),
        .zero(zero),
        .ALUop(ALUop),
        .op(op),
        .RD_reg1(RD_reg1),
        .RD_reg2(RD_reg2),
        .WR_reg(WR_reg),
        .curPC(curPC),
        .nextPC(nextPC),
        .instruction(instruction),
        .RD_data1(RD_data1),
        .RD_data2(RD_data2),
        .WR_data(WR_data),
        .ext_immediate(ext_immediate),
        .ext_immediate_shift(ext_immediate_shift),
        .ALU_inputA(ALU_inputA),
        .ALU_inputB(ALU_inputB),
        .result(result),
        .memory_out(memory_out)
    );
    
    always #30 clk = ~clk;
    initial begin
        clk = 0;
        reset = 0;
        #60 reset = 1;
    end
    
   
endmodule
