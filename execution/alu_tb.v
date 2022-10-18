// https://www.edaplayground.com/x/ep63
`timescale 1ns / 1ps
+define+FILE="ALU.v"
`include `FILE
module main;
    reg clk;
    reg reset;
    integer data1;
    integer data2;
    integer result;
    
    reg [3:0] ALUControl;
    
    wire zero;
    

    ALUUnit tb (
        // .clk (clk),
        .reset (reset),
        .data1 (data1),
        .data2 (data2),
        .ALUControl (ALUControl),
        .result (result),
        .zero (zero)
    );

    initial 
    begin
        clk = 1'b0;
        forever #1 clk = ~clk;
    end

    initial 
    begin
        reset = 1'b1;
        #10 reset = 1'b0;
    end

    initial 
    begin
        $display ("time=%3d, result=%b, zero=%b \n", $time, result, zero);
        $finish;
        #20
        data1 = 5;
        data2 = 4;
        ALUControl = 4'b0000;


    end

endmodule
