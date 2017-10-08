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
    input clk,
    input zero,
    input reset,
    output reg [1:0] RegDst,
    output reg WRRegDSrc,
    output reg RegWre,
    output reg ExtSel,
    output reg ALUSrcB,
    output reg ALUSrcA,
    output reg [2:0] ALUop,
    output reg DBdataSrc,
    output reg [1:0] PCSrc,
    output reg DataMemWrite,
    output reg DataMemRead,
    output reg PCWre,
    output reg insMemWR
    );
    
    reg [2:0] current_state, next_state;
    initial begin
        PCWre = 1;
        insMemWR = 1;
        current_state = 2'b000;
    end
    
    // state transition  
    always@ (posedge clk) begin
        current_state = next_state;
    end
    
    // determine next_state
    always@ (*) begin
        if(reset == 0)
            next_state = 0;
        else begin
            case(current_state)
                0 : next_state = 1;
                1 : begin
                    if(op == 0 || op == 1 || op == 2 || op == 16 || op == 17 || op == 18 || op == 38 || op == 39 || op == 24)
                        next_state = 6;
                    else if(op == 52 || op == 53)
                        next_state = 5;
                    else if(op == 48 || op == 49)
                        next_state = 2;
                    else if(op == 56 || op == 57 || op == 58 || op == 63)
                        next_state = 0;
                end
                2 : next_state = 3;
                3 : begin
                    if(op == 48)
                        next_state = 0;
                    else 
                        next_state = 4;
                end
                4 : next_state = 0;
                5 : next_state = 0;
                6 : next_state = 7;
                7 : next_state = 0;
                default : next_state = 0;
            endcase
        end
    end
    // output function based on state and op
    
    always@ (*) begin
        case(op)
            0 : begin // add
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;
                end                    
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    RegDst = 2;
                    PCSrc = 0;
                end
                else if(current_state == 6) begin
                    ALUSrcA = 0;
                    ALUSrcB = 0;
                    ALUop = 0;
                    DBdataSrc = 0;
                end
                else if(current_state == 7) begin
                    WRRegDSrc = 1;
                    RegWre = 1;
                    PCWre = 1;
                end
            end
                
            1 : begin // sub
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;
                end
                else if(current_state == 1) begin
                    RegDst = 2;
                    RegWre = 0;
                    PCWre = 0;
                    PCSrc = 0;
                end
                else if(current_state == 6) begin
                    ALUSrcA = 0;
                    ALUSrcB = 0;
                    ALUop = 1;
                    DBdataSrc = 0;
                end
                else if(current_state == 7) begin
                    RegWre = 1;
                    WRRegDSrc = 1;
                    PCWre = 1;
                end          
            end
                
            2 : begin // addi
               if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;
                end                    
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    RegDst = 1;
                    PCSrc = 0;
                    ExtSel = 1;
                end
                else if(current_state == 6) begin
                    ALUSrcA = 0;
                    ALUSrcB = 1;
                    ALUop = 0;
                    DBdataSrc = 0;
                end
                else if(current_state == 7) begin
                    WRRegDSrc = 1;
                    RegWre = 1;
                    PCWre = 1;
                end 
            end
                
            16 : begin // or
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;
                end                    
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    RegDst = 2;
                    PCSrc = 0;
                end
                else if(current_state == 6) begin
                    ALUSrcA = 0;
                    ALUSrcB = 0;
                    ALUop = 5;
                    DBdataSrc = 0;
                end
                else if(current_state == 7) begin
                    WRRegDSrc = 1;
                    RegWre = 1;
                    PCWre = 1;
                end 
            end
                
            17 : begin // and
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;
                end                    
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    RegDst = 2;
                    PCSrc = 0;
                end
                else if(current_state == 6) begin
                    ALUSrcA = 0;
                    ALUSrcB = 0;
                    ALUop = 6;
                    DBdataSrc = 0;
                end
                else if(current_state == 7) begin
                    WRRegDSrc = 1;
                    RegWre = 1;
                    PCWre = 1;
                end 
            end
                
            18 : begin // ori
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;
                end                    
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    RegDst = 1;
                    PCSrc = 0;
                    ExtSel = 1;
                end
                else if(current_state == 6) begin
                    ALUSrcA = 0;
                    ALUSrcB = 1;
                    ALUop = 5;
                    DBdataSrc = 0;
                end
                else if(current_state == 7) begin
                    WRRegDSrc = 1;
                    RegWre = 1;
                    PCWre = 1;
                end
            end
            
            38 : begin // slt
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;
                end                    
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    RegDst = 2;
                    PCSrc = 0;
                end
                else if(current_state == 6) begin
                    ALUSrcA = 0;
                    ALUSrcB = 0;
                    ALUop = 3;
                    DBdataSrc = 0;
                end
                else if(current_state == 7) begin
                    WRRegDSrc = 1;
                    RegWre = 1;
                    PCWre = 1;
                end 
            end
            
            39 : begin // sltu
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;
                end                    
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    RegDst = 2;
                    PCSrc = 0;
                end
                else if(current_state == 6) begin
                    ALUSrcA = 0;
                    ALUSrcB = 0;
                    ALUop = 2;
                    DBdataSrc = 0;
                end
                else if(current_state == 7) begin
                    WRRegDSrc = 1;
                    RegWre = 1;
                    PCWre = 1;
                end 
            end            
            
            24 : begin // sll
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;
                end                    
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    RegDst = 2;
                    PCSrc = 0;
                end
                else if(current_state == 6) begin
                    ALUSrcA = 1;
                    ALUSrcB = 0;
                    ALUop = 4;
                    DBdataSrc = 0;
                end
                else if(current_state == 7) begin
                    WRRegDSrc = 1;
                    RegWre = 1;
                    PCWre = 1;
                end 
            end            
            
            48 : begin // sw
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;
                end                    
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    PCSrc = 0;
                    ExtSel = 1;
                end
                else if(current_state == 2) begin
                    ALUSrcA = 0;
                    ALUSrcB = 1;
                    ALUop = 0;
                end
                else if(current_state == 3) begin
                    DataMemWrite = 1;  
                    PCWre = 1;                  
                end 
            end 
                
            49 : begin // lw
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;
                end                    
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    RegDst = 1;
                    PCSrc = 0;
                    ExtSel = 1;
                end
                else if(current_state == 2) begin
                    ALUSrcA = 0;
                    ALUSrcB = 1;
                    ALUop = 0;
                end
                else if(current_state == 3) begin
                    DataMemRead = 1; 
                    DBdataSrc = 1;                   
                end 
                else if(current_state == 4) begin
                    WRRegDSrc = 1;
                    RegWre = 1;  
                    PCWre = 1;                  
                end
            end 
                 
            52 : begin // beq
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;
                end                    
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    RegDst = 2;
                    ExtSel = 1;
                end
                else if(current_state == 5) begin
                    ALUSrcA = 0;
                    ALUSrcB = 0;
                    ALUop = 1;
                    PCWre = 1;
                    if(zero == 1)
                        PCSrc = 1;
                    else
                        PCSrc = 0;
                end
            end
             
            53 : begin // bne
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;
                end                    
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    RegDst = 2;
                    ExtSel = 1;
                end
                else if(current_state == 5) begin
                    ALUSrcA = 0;
                    ALUSrcB = 0;
                    ALUop = 1;
                    PCWre = 1;
                    if(zero == 0)
                        PCSrc = 1;
                    else
                        PCSrc = 0;
                end
            end 
                  
            56 : begin // j
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;                    
                end
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    PCSrc = 3;
                    PCWre = 1;
                end
            end
            
            57 : begin // jr
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;                    
                end
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                    PCSrc = 2;
                    PCWre = 1;
                end
            end 
            
            58 : begin // jal
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;                    
                end
                else if(current_state == 1) begin
                    PCWre = 0;
                    PCSrc = 3;
                    RegDst = 0;
                    RegWre = 1;
                    WRRegDSrc = 0;
                    PCWre = 1;
                end
            end                       
 
            63 : begin // halt
                if(current_state == 0) begin
                    PCWre = 0;
                    RegWre = 0;
                    DataMemWrite = 0;                    
                end
                else if(current_state == 1) begin
                    PCWre = 0;
                    RegWre = 0;
                end
            end  
                    
            default : begin
                PCWre = 0;
                RegWre = 0;
                DataMemWrite = 0;                
            end
                       
         endcase
    end
endmodule
