`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/16 21:01:23
// Design Name: 
// Module Name: MCPU
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


module MCPU(
    input clk,
    input reset,
    output WRRegDSrc, RegWre, ExtSel, ALUSrcA, ALUSrcB, DBdataSrc, DataMemWrite, DataMemRead, PCWre, insMemWR, zero,
    output [1:0] RegDst, PCSrc,
    output [2:0] ALUop,
    output [4:0] sa, RD_reg1_addr, RD_reg2_addr, WR_reg_addr,
    output [5:0] op,
    output [31:0] RD_data1, RD_data2, result, ADR_out, BDR_out, ALUDR_out, DBDR_in, DBDR_out, data_addr, data_in, 
                  memory_out, instructionMemory_out, instruction, ext_immediate, ALU_inputA, ALU_inputB, 
                  ext_immediate_shift, curPC, nextPC, WR_data, jumpAddr_extend  
    );
    
    assign op = instruction[31:26];
    assign RD_reg1_addr = instruction[25:21];
    assign RD_reg2_addr = instruction[20:16];
    assign sa = instruction[10:6];
    assign data_in = BDR_out;
    assign data_addr = ALUDR_out;
    
    ALU my_ALU(ALUop, ALU_inputA, ALU_inputB, result, zero);
    
    ADR my_ADR(RD_data1, clk, ADR_out);
    
    ALUoutDR my_ALUoutDR(result, clk, ALUDR_out);
    
    BDR my_BDR(RD_data2, clk, BDR_out);
    
    IR my_IR(instructionMemory_out, clk, instruction);
    
    DBDR my_DBDR(DBDR_in, clk, DBDR_out);
    
    DataMemory my_DataMemory(clk, data_addr, data_in, DataMemRead, DataMemWrite, memory_out);
    
    Mux_ALUSrcA my_ALUSrcA(ADR_out, ALUSrcA, sa, ALU_inputA);
    
    Mux_ALUSrcB my_ALUSrcB(BDR_out, ALUSrcB, ext_immediate, ALU_inputB);
    
    Mux_ALU_memory_to_reg my_ALU_memory_to_reg(DBdataSrc, result, memory_out, DBDR_in);
    
    Mux_PCSrc my_PCSrc(PCSrc, curPC, ext_immediate_shift, RD_data1, jumpAddr_extend, nextPC);
    
    Mux_RegDst my_RegDst(RegDst, RD_reg2_addr, instruction[15:11], WR_reg_addr);
    
    Mux_WRdataSrc my_WRdataSrc(WRRegDSrc, DBDR_out, curPC, WR_data);
    
    Mux_signExtend my_signExt(ExtSel, instruction[15:0], ext_immediate);
    
    PC my_PC(clk, reset, PCWre, nextPC, curPC);
    
    Register my_register(clk, RegWre, RD_reg1_addr, RD_reg2_addr, WR_reg_addr, WR_data, RD_data1, RD_data2);
    
    addr_shift my_shift(ext_immediate, ext_immediate_shift);
    
    instructionMemory my_instructionMemory(curPC, insMemWR, instructionMemory_out);
    
    jumpInsExtend my_jumpInsExtend(curPC, instruction[25:0], jumpAddr_extend);
    
    control_unit my_control_unit(op, clk, zero, reset, RegDst, WRRegDSrc, RegWre, ExtSel, ALUSrcB, ALUSrcA, ALUop, DBdataSrc,
                                 PCSrc, DataMemWrite, DataMemRead, PCWre, insMemWR);
    
endmodule
