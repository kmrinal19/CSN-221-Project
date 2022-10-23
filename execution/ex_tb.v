`timescale 1ns / 1ps
`include "EX.v"
module testb;
    reg clk;
    reg reset;
    integer rs;
    integer rt;
    integer sign_ext;
    integer pc;
    reg ALUSrc;
    reg [1:0] ALUOp;
    reg [5:0] funct;
  	reg branch;
    wire [31:0] address;
    wire zero;
    wire [31:0] resultOut;
    wire [31:0] pcout;
    wire [31:0] offset;

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
        .pcout (pcout),
      	.branch (branch),
        .offset (offset)
    );

    initial 
    begin
        clk = 1'b0;
        forever #1 clk = ~clk;
    end

    initial 
    begin
        reset = 1'b1;
        #100 reset = 1'b0;
    end

    initial 
    begin
        #20
        rs = 5;
        rt = 5;
        pc = 4;
        sign_ext = 5;
        ALUSrc = 1'b1;
        funct = 6'b000010;
        ALUOp = 2'b01;
      	branch = 1'b1;
        #40
      	$finish;

        

    end

endmodule
