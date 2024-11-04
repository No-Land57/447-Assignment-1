`timescale 1ns / 1ps

module Hamming_Decoder(
    input wire [6:0] IN,
    input wire CLK,
    input wire RESET,
    output reg [3:0] OUT,
    output reg ERROR
    );
    
    reg [6:0] corrected_code;
    reg [2:0] checkbit;
    reg [2:0] index; // inverted checkbit array to get index in the original input since checkbit array produces value counted from the left of the orignal input. Use this to change the value at the actual index counted from the LSB.
    reg [3:0] testout;

    // Calculate the checkbit bits in a combinational always block
    always @(*) begin
        checkbit[0] = IN[6] ^ IN[4] ^ IN[2] ^ IN[0];
        checkbit[1] = IN[5] ^ IN[4] ^ IN[1] ^ IN[0];
        checkbit[2] = IN[3] ^ IN[2] ^ IN[1] ^ IN[0];
        
        index = ~checkbit;  // Calculate the error position index
    end
    
    always @(posedge CLK, negedge RESET) begin
        if (!RESET) begin
            OUT <= 4'b0;
            ERROR <= 1'b0;
            corrected_code <= 7'b0;
        end else begin
            corrected_code <= IN;

                // Correct the bit at the error index
                case (index)
                    3'b000: corrected_code[0] <= ~IN[0];
                    3'b001: corrected_code[1] <= ~IN[1];
                    3'b010: corrected_code[2] <= ~IN[2];
                    3'b011: corrected_code[3] <= ~IN[3];
                    3'b100: corrected_code[4] <= ~IN[4];
                    3'b101: corrected_code[5] <= ~IN[5];
                    3'b110: corrected_code[6] <= ~IN[6];
                    3'b111: corrected_code <= IN; // No error or uncorrectable error
                    default: corrected_code <= IN;
                endcase
                
                if(index == 3'b111) begin
                   ERROR <= 1'b0;
                   end else begin
                   ERROR <= 1'b1;
                   end
                   
                 OUT <= {corrected_code[4], corrected_code[2], corrected_code[1], corrected_code[0]};         
            end
        end
endmodule