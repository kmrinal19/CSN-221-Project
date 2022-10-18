`timescale 1ns / 1ps
`include "IF_Unit/Instruction_Memory.v"

module testb;
    reg clk;
	reg reset;
    integer pc;
    reg [31:0] Imemory [0:1023];
    wire [31:0] inp_instn;
    wire [31:0] nextpc;
    wire [31:0] pc_to_branch;

    Instruction_Memory tb (
        .clk(clk),
        .pc(pc),
      	.reset(reset),
        .inp_instn(inp_instn),
        .nextpc(nextpc),
        .pc_to_branch(pc_to_branch)
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

        #10
      
      	pc = 32'd4;
      	
      	#30
      
      $display ("time=%3d, inp_instn=%b, nextpc=%b, pc_to _branch=%b \n", $time, inp_instn, nextpc, pc_to_branch);
        $finish;

    end

endmodule


