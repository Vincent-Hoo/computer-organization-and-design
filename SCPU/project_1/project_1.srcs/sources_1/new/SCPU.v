`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 21:22:04
// Design Name: 
// Module Name: SCPU
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


module SCPU(
    input clk,
    input reset,
    output  PCWre,
    output  RegWre, insMemWR, RegDst, ExtSel, ALUSrcB, DBdataSrc, PCSrc, DataMemRW, zero,
    output [2:0] ALUop,
    output [5:0] op,
    output [4:0] RD_reg1, RD_reg2, WR_reg,
    output [31:0] curPC, nextPC, instruction, RD_data1, RD_data2, WR_data, ext_immediate, ext_immediate_shift,
                  ALU_inputA, ALU_inputB, result, memory_out
    );
    
    assign op = instruction[31:26];
    assign RD_reg1 = instruction[25:21];
    assign RD_reg2 = instruction[20:16];
//    wire unextended;
//    assign unextended = instruction[15:0];
    assign ALU_inputA = RD_data1;
    //assign insMemWR = 1;
  /*  
    initial begin
        PCWre = 1;
    end
    */
   // assign PCWre = 1;
    
    PC my_PC(clk, reset, PCWre, nextPC, curPC);
    
    instructionMemory encoding(curPC, insMemWR, instruction);
    
    control_unit my_control_unit(op, RegDst, RegWre, ExtSel, ALUSrcB, ALUop, DBdataSrc, PCSrc, DataMemRW, PCWre, insMemWR);
    
    Mux_RegDst my_RegDst(RegDst, RD_reg2, instruction[15:11], WR_reg);
    
    Mux_signExtend my_extend(ExtSel, instruction[15:0], ext_immediate);
    
    Register my_register(clk, RegWre, RD_reg1, RD_reg2, WR_reg, WR_data, RD_data1, RD_data2);
    
    Mux_ALUSrc my_ALUSrc(ALUSrcB, RD_data2, ext_immediate, ALU_inputB);
    
    ALU my_ALU(ALUop, ALU_inputA, ALU_inputB, result, zero);
    
    DataMemory my_memory(clk, result, RD_data2, DataMemRW, memory_out);
    
    Mux_ALU_memory_to_reg my_ALU_memory_to_reg(DBdataSrc, result, memory_out, WR_data);
    
    addr_shift my_shift(ext_immediate, ext_immediate_shift);
    
    Mux_PCSrc my_PCSrc(PCSrc, curPC, ext_immediate_shift, zero, nextPC);
    
endmodule
