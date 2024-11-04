`timescale 1ns / 1ps

module Encoder_Decoder_TB;

    reg [3:0] IN;
    reg CLK;
    reg RESET;
    wire [3:0] OUT;
    wire ERROR;
    wire [6:0] EncodeOut;
    
    Hamming_Encoder encoderuut (
        .IN(IN),
        .CLK(CLK),
        .RESET(RESET),
        .OUT(EncodeOut) 
    );

    // Instantiate the Hamming_Decoder module
    Hamming_Decoder decoderuut (
        .IN(EncodeOut),
        .CLK(CLK),
        .RESET(RESET),
        .OUT(OUT),
        .ERROR(ERROR)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  // 10ns clock period
    end

    // Test sequence
    initial begin
        // Display header
        $display("Time\tIN\t\tOUT\tERROR");

        // Initialize inputs
        RESET = 0;
        IN = 4'b0000;
        #10 RESET = 1;  // Release reset after 10ns

        #10 IN = 4'b0001; // Expected OUT = 0001, ERROR = 0
        #10

        #10 IN = 4'b0010; // Should correct to 0001, ERROR = 1
        #10

        #10 IN = 4'b0011; // Should correct to 0001, ERROR = 1

        #10 IN = 4'b0100; // Should correct to 0001, ERROR = 1

        #10 IN = 4'b0101; // Expected OUT = 1010, ERROR = 0

        #10 IN = 4'b0110; // Should correct to 1010, ERROR = 1

        #10 IN = 4'b0111; // Expected OUT = 0000, ERROR = 0

        #10 $stop;
    end

endmodule
