`timescale 1ns / 1ps

module Hamming_Encoder_TB(
    );
    
    reg [3:0] IN;
    reg CLK;
    reg RESET;
    
    wire [6:0] OUT;
    
    Hamming_Encoder uut (
        .IN(IN),
        .CLK(CLK),
        .RESET(RESET),
        .OUT(OUT)
        );
        
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  // 10ns clock period (100MHz)
    end
    
    initial begin
    
        // Test Case 1: Reset the system
        RESET = 0;              // Apply reset
        #10 RESET = 1;          // Release reset after 10ns
        #10;
        
        // Input pattern 0000
        IN = 4'b0000;
        #10;
        
        // Input pattern 0001
        IN = 4'b0001;
        #10;
        
        // Input pattern 0010
        IN = 4'b0010;
        #10;
        
        // Input pattern 0011
        IN = 4'b0011;
        #10;
        
        // Input pattern 1010
        IN = 4'b1010;
        #10;
        
         // Input pattern 1111
        IN = 4'b1111;
        #10;

        $finish;
    end
 
endmodule
