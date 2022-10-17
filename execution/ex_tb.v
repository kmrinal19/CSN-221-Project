`timescale 1ns / 1ps
+define+FILE="EX.v"
`include `FILE
module example_tb();
    reg clk;
    reg reset;
    integer rs;
    integer rt;
    reg [31:0] sign_ext;
    reg [31:0] pc;
    reg ALUSrc;
    reg [1:0] ALUOp;
    reg [5:0] funct;
    wire [31:0] address;
    wire zero;
    wire [31:0] resultOut;
    wire [31:0] pcout;

    EX tb (
        .clk (clk),
        .reset (reset),
        .rs (rs),
        .rt (rt),
        .sign_ext (sign_ext),
        .ALUSrc (ALUSrc),
        .ALUOp (ALUOp),
        .funct (funct),
        .pc (pc),
        .address(address),
        .zero (zero),
        .resultOut(resultOut),
        .pcout (pcout)
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
        $display ("time=%3d, address=%b, zero=%b, result=%d, pcout=%b \n", $time, address, zero, resultOut, pcout);
        #20
        rs = 32'd5;
        rt = 32'd3;
        pc = 32'd4;
        sign_ext = 32'd6;
        ALUSrc = 1'b0;
        funct = 6'b000000;
        ALUOp = 2'b10;

    end

endmodule
