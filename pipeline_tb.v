`timescale 1ns / 1ps
`include "pipeline.v"
module testb;
    reg clk;
    reg reset;
    
    pipeline tb (
        .clk (clk),
        .reset (reset)
        );
        

    initial 
    begin
        clk = 1'b0;
        forever #4 clk = ~clk;
    end

    initial 
    begin
        reset = 1'b1;
        #100 reset = 1'b0;
    end

    

endmodule
