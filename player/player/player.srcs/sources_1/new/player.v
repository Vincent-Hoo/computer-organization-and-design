`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/21 19:58:30
// Design Name: 
// Module Name: player
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


module player(
    input wire clk,
    output reg speaker
    );
    
    reg clk_6mhz, clk_4hz;
    reg [13:0] divider, origin;
    reg carry;
    reg [5:0] counter;
    reg [3:0] high, med, low;
    reg [3:0] count16;
    reg [20:0] count20;
    
    always @( posedge clk)//get 6MHz clock
    begin
        if(count16 == 15 )
            begin
                count16 <= 0;
                clk_6mhz <= 1;
            end
        else
            begin
                count16 <= count16 + 1;
                clk_6mhz <= 0;
            end
    end
    
    always @( posedge clk_6mhz )//get 2Hz clock
    begin
        if(count20 == 781250*2)
            begin
                clk_4hz = ~clk_4hz;
                count20 <= 0;
            end
        else
            count20 <= count20 + 1;
    end
    
    always @( posedge clk_6mhz )
    begin
        if( divider == 16383 )
            begin
                carry <= 1;
                divider <= origin;
            end
        else
            begin
                divider <= divider + 1;
                carry <= 0;
            end
    end
    
    always @( posedge carry)
    begin
        speaker <= ~speaker;
    end
    
    always @(posedge clk_4hz)
    begin
        case( {high, med, low} )
            'h001: origin <= 4915;
            'h002: origin <= 6168;
            'h003: origin <= 7281;
            'h004: origin <= 7792;
            'h005: origin <= 8730;
            'h006: origin <= 9565;
            'h007: origin <= 10310;
            'h010: origin <= 10647;
            'h020: origin <= 11272;
            'h030: origin <= 11831;
            'h040: origin <= 12094;
            'h050: origin <= 12556;
            'h060: origin <= 12974;
            'h070: origin <= 13346;  
            'h100: origin <= 13516;
            'h200: origin <= 13829;
            'h300: origin <= 14109;
            'h400: origin <= 14235;
            'h500: origin <= 14470;
            'h600: origin <= 14678;
            'h700: origin <= 14864;
            'h000: origin <= 16383;                      
        endcase
    end
    
    always @( posedge clk_4hz )
    begin
        if( counter == 55 )
            counter <= 0;
        else
            counter <= counter + 1;
             
        case( counter )
            0: {high, med, low} <= 'h005;
            1: {high, med, low} <= 'h005;
            2: {high, med, low} <= 'h006; 
            3: {high, med, low} <= 'h006;
            4: {high, med, low} <= 'h005; 
            5: {high, med, low} <= 'h005;
            6: {high, med, low} <= 'h010; 
            7: {high, med, low} <= 'h010;
            8: {high, med, low} <= 'h007; 
            9: {high, med, low} <= 'h007;
            10: {high, med, low} <= 'h007; 
            11: {high, med, low} <= 'h007;  
            12: {high, med, low} <= 'h005;
            13: {high, med, low} <= 'h005;
            14: {high, med, low} <= 'h006; 
            15: {high, med, low} <= 'h006;
            16: {high, med, low} <= 'h005; 
            17: {high, med, low} <= 'h005;
            18: {high, med, low} <= 'h020; 
            19: {high, med, low} <= 'h020;
            20: {high, med, low} <= 'h010; 
            21: {high, med, low} <= 'h010;
            22: {high, med, low} <= 'h010; 
            23: {high, med, low} <= 'h010;
            24: {high, med, low} <= 'h005;
            25: {high, med, low} <= 'h005;
            26: {high, med, low} <= 'h050; 
            27: {high, med, low} <= 'h050;
            28: {high, med, low} <= 'h030; 
            29: {high, med, low} <= 'h030;
            30: {high, med, low} <= 'h010; 
            31: {high, med, low} <= 'h010;
            32: {high, med, low} <= 'h007; 
            33: {high, med, low} <= 'h007;
            34: {high, med, low} <= 'h006; 
            35: {high, med, low} <= 'h006;
            36: {high, med, low} <= 'h000; 
            37: {high, med, low} <= 'h000;
            38: {high, med, low} <= 'h000; 
            39: {high, med, low} <= 'h000;
            40: {high, med, low} <= 'h040;
            41: {high, med, low} <= 'h040;
            42: {high, med, low} <= 'h030; 
            43: {high, med, low} <= 'h030;
            44: {high, med, low} <= 'h010; 
            45: {high, med, low} <= 'h010;
            46: {high, med, low} <= 'h020; 
            47: {high, med, low} <= 'h020;
            48: {high, med, low} <= 'h010; 
            49: {high, med, low} <= 'h010;
            50: {high, med, low} <= 'h010; 
            51: {high, med, low} <= 'h010;
            52: {high, med, low} <= 'h000; 
            53: {high, med, low} <= 'h000;
            54: {high, med, low} <= 'h000; 
            55: {high, med, low} <= 'h000;                                   
            default: {high, med, low} <= 'h000;       
        endcase
    end    

endmodule
