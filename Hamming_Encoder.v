`timescale 1ns / 1ps

module Hamming_Encoder(
    input wire [3:0] IN,
    input wire CLK,
    input wire RESET,
    output wire [6:0] OUT
    );
    
    reg [6:0] output_register;
    reg c0, c2, c4;
    
    always @(posedge CLK, negedge RESET) begin
        if (!RESET) begin
            output_register <= 7'b0;
        end else begin
            // Calculate check bits
             c4 = IN[2] ^ IN[1] ^ IN[0];
             c2 = IN[3] ^ IN[1] ^ IN[0];
             c0 = IN[3] ^ IN[2] ^ IN[0];

            // Assign code bits
            output_register[0] <= IN[0];
            output_register[1] <= IN[1];
            output_register[2] <= IN[2];
            output_register[3] <= c4;
            output_register[4] <= IN[3];
            output_register[5] <= c2;
            output_register[6] <= c0;
        end
    end

    assign OUT = output_register;

endmodule




