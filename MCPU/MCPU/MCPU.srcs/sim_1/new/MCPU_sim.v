`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/16 22:38:52
// Design Name: 
// Module Name: MCPU_sim
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


module MCPU_sim();
    
    reg clk, reset;
    wire WRRegDSrc, RegWre, ExtSel, ALUSrcA, ALUSrcB, DBdataSrc, DataMemWrite, DataMemRead, PCWre, insMemWR, zero;
    wire [1:0] RegDst, PCSrc;
    wire [2:0] ALUop;
    wire [4:0] sa, RD_reg1_addr, RD_reg2_addr, WR_reg_addr;
    wire [5:0] op;
    wire [31:0] RD_data1, RD_data2, result, ADR_out, BDR_out, ALUDR_out, DBDR_in, DBDR_out, data_addr, data_in, 
                      memory_out, instructionMemory_out, instruction, ext_immediate, ALU_inputA, ALU_inputB, 
                      ext_immediate_shift, curPC, nextPC, WR_data, jumpAddr_extend;  
                  
    MCPU my_CPU(
        .clk(clk),
        .reset(reset),
        .WRRegDSrc(WRRegDSrc),
        .RegWre(RegWre),
        .ExtSel(ExtSel),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .DBdataSrc(DBdataSrc),
        .DataMemWrite(DataMemWrite),
        .DataMemRead(DataMemRead),
        .PCWre(PCWre),
        .insMemWR(insMemWR),
        .zero(zero),
        .RegDst(RegDst),
        .PCSrc(PCSrc),
        .ALUop(ALUop),
        .sa(sa),
        .RD_reg1_addr(RD_reg1_addr),
        .RD_reg2_addr(RD_reg2_addr),
        .WR_reg_addr(WR_reg_addr),
        .op(op),
        .RD_data1(RD_data1),
        .RD_data2(RD_data2),        
        .result(result),
        .ADR_out(ADR_out),
        .BDR_out(BDR_out),
        .ALUDR_out(ALUDR_out),      
        .DBDR_in(DBDR_in),
        .DBDR_out(DBDR_out),
        .data_addr(data_addr),
        .data_in(data_in), 
        .memory_out(memory_out),
        .instructionMemory_out(instructionMemory_out),
        .instruction(instruction),
        .ALU_inputA(ALU_inputA),        
        .ALU_inputB(ALU_inputB),
        .ext_immediate(ext_immediate),
        .ext_immediate_shift(ext_immediate_shift),
        .curPC(curPC), 
        .nextPC(nextPC),
        .WR_data(WR_data),
        .jumpAddr_extend(jumpAddr_extend)
    );
    
    always #30 clk = ~clk;
    initial begin
        clk = 0;
        reset = 0;
        #60 reset = 1;
    end
    
    
endmodule
