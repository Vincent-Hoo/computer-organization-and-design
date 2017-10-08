`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/21 14:51:10
// Design Name: 
// Module Name: SCPU_top
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


module SCPU_top(
    input wire clk,
    input wire reset,
    input wire button,
    input wire choice,
    input wire [2:0] s1,
    input wire [1:0] s,
    output wire [3:0] an,
    output wire [6:0] a_to_g,
    output wire dp,
    output wire L
    );
    
    wire clk_25MHz;
    wire clk_1kHz;
    wire button_after_scaning;
    wire impluse;
        
    clk_div clock(clk, clk_25MHz, clk_1kHz);
    
    Button_Scaning button_out(clk_25MHz, button, button_after_scaning);
    
    artificial_impulse imp(button_after_scaning, impulse);
    
    assign L = impulse;
    
    wire [15:0] num;
    wire PCWre, RegWre, insMemWR, RegDst, ExtSel, ALUSrcB, DBdataSrc, PCSrc, DataMemRW, zero;
    wire [2:0] ALUop;
    wire [5:0] op;
    wire [4:0] RD_reg1, RD_reg2, WR_reg;
    wire [31:0] curPC, nextPC, instruction, RD_data1, RD_data2, WR_data, ext_immediate, ext_immediate_shift,
                  ALU_inputA, ALU_inputB, result, memory_out;
    wire [31:0] re0, re1, re2, re3, re4, re5, re6, re7;
     
    SCPU myCPU(
          .clk(impulse),
          .reset(reset),
          .choice(choice),
          .s1(s1),
          .s(s),
          .num(num),
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
          .memory_out(memory_out),
          .re0(re0),
          .re1(re1),
          .re2(re2),
          .re3(re3),
          .re4(re4),
          .re5(re5),
          .re6(re6),
          .re7(re7)
      );              
    
      seg7 my_seg7(.x(num), .clk(clk_1kHz), .clr(reset), .an(an), .a_to_g(a_to_g), .dp(dp));
      
    
endmodule
