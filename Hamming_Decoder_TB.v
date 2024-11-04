`timescale 1ns / 1ps

module Hamming_Decoder_TB;

    reg [6:0] IN;
    reg CLK;
    reg RESET;
    wire [3:0] OUT;
    wire ERROR;

    // Instantiate the Hamming_Decoder module
    Hamming_Decoder decoderuut (
        .IN(IN),
        .CLK(CLK),
        .RESET(RESET),
        .OUT(OUT),
        .ERROR(ERROR)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  
    end

    // Test sequence
    initial begin

        // Initialize inputs
        RESET = 0;  // Reset
        IN = 7'b0000000;
        #10 RESET = 1;  

        #10 IN = 7'b1101001; // Expected OUT = 0001, ERROR = 0

        #10 IN = 7'b1101001; // Should correct to 0001, ERROR = 1

        #10 IN = 7'b1101010; // Should correct to 0001, ERROR = 1

        #10 IN = 7'b1001000; // Should correct to 0001, ERROR = 1

        #10 IN = 7'b0110011; // Expected OUT = 1010, ERROR = 0

        #10 IN = 7'b1110011; // Should correct to 1010, ERROR = 1

        #10 IN = 7'b0000000; // Expected OUT = 0000, ERROR = 0

        #10 $stop;
    end

endmodule
