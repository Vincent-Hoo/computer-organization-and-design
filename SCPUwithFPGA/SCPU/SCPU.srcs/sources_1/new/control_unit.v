`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 17:02:51
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [5:0] op,
    //input zero,
    output reg RegDst,
    output reg RegWre,
    output reg ExtSel,
    output reg ALUSrcB,
    output reg [2:0] ALUop,
    output reg DBdataSrc,
    output reg PCSrc,
    output reg DataMemRW,
    output reg PCWre,
    output reg insMemWR
    );
    
    initial begin
        PCWre = 1;
        insMemWR = 1;
    end
    
    always@ (*) begin
        case(op)
            0 : begin // add
                    RegDst = 1;
                    RegWre = 1;
                    ALUSrcB = 0;
                    ALUop = 0;
                    DBdataSrc = 0;
                    DataMemRW = 0;
                    PCSrc = 0;
                    PCWre = 1;
                end
                
            1 : begin // addi
                   RegDst = 0;
                   RegWre = 1;
                   ExtSel = 1;
                   ALUSrcB = 1;
                   ALUop = 0;
                   DBdataSrc = 0;
                   DataMemRW = 0;
                   PCSrc = 0;
                   PCWre = 1;
                end
                
            2 : begin // sub
                    RegDst = 1;
                    RegWre = 1;
                    ALUSrcB = 0;
                    ALUop = 1;
                    DBdataSrc = 0;
                    DataMemRW = 0;
                    PCSrc = 0;
                    PCWre = 1;
                end
                
            16 : begin // ori
                    RegDst = 0;
                    RegWre = 1;
                    ExtSel = 0;
                    ALUSrcB = 1;
                    ALUop = 3'b011;
                    DBdataSrc = 0;
                    DataMemRW = 0;
                    PCSrc = 0;
                    PCWre = 1;
                end
                
            17 : begin // and
                    RegDst = 1;
                    RegWre = 1;
                    ALUSrcB = 0;
                    ALUop = 3'b100;
                    DBdataSrc = 0;
                    DataMemRW = 0;
                    PCSrc = 0;
                    PCWre = 1;
                end
                
            18 : begin // or
                    RegDst = 1;
                    RegWre = 1;
                    ALUSrcB = 0;
                    ALUop = 3'b011;
                    DBdataSrc = 0;
                    DataMemRW = 0;
                    PCSrc = 0;
                    PCWre = 1;
                end
                
            32 : begin // move
                    RegDst = 1;
                    RegWre = 1;
                    ALUSrcB = 0;
                    ALUop = 0;
                    DBdataSrc = 0;
                    DataMemRW = 0;
                    PCSrc = 0;
                    PCWre = 1;
                 end
                
            38 : begin // sw
                    RegWre = 0;
                    ExtSel = 1;
                    ALUSrcB = 1;
                    ALUop = 0;
                    DataMemRW = 1;
                    DBdataSrc = 1;
                    PCSrc = 0;
                    PCWre = 1;
                 end
                 
             39 : begin // lw
                     RegDst = 0;
                     RegWre = 1;
                     ExtSel = 1;
                     ALUSrcB = 1;
                     ALUop = 0;
                     DataMemRW = 0;
                     DBdataSrc = 1;
                     PCSrc = 0;
                     PCWre = 1;
                  end
                  
              48 : begin // beq
                       RegWre = 0;
                       ExtSel = 1;
                       ALUSrcB = 0;
                       ALUop = 3'h001;
                       DataMemRW = 0;
                       PCSrc = 1;
                       PCWre = 1;
                    end
                    
               63 : PCWre = 0;
                    
             default : begin
                            RegWre = 0;
                            ExtSel = 1;
                            ALUSrcB = 0;
                            DataMemRW = 0;
                            ALUop = 3'h001;
                            PCSrc = 1;   
                       end
                       
         endcase
    end
endmodule
