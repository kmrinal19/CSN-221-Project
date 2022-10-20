module Instruction_Memory(clk, pc, inp_instn, nextpc, pc_to_branch, reset);

input clk;
input wire reset;
input wire [31:0] pc;
// reg [31:0] pc_reg;
reg [31:0] Imemory [0:1023];
output reg [31:0] inp_instn;
output reg [31:0] nextpc;
output reg [31:0] pc_to_branch;

initial //for testing
    begin
        $readmemb("Icode.txt", Imemory);
    end

always @ (posedge reset)
    begin
        inp_instn  <= Imemory[0];
        nextpc <= 32'd4;
        pc_to_branch <= 32'd0;
        #1
        $display ("time=%3d, inp_instn=%b, nextpc=%b, pc_to _branch=%b \n", $time, inp_instn, nextpc, pc_to_branch);

    end
always @ (pc)
    begin
        #20  //enabling this leads to $readmemb: Unable to open Icode.txt for reading.
        $display ("time=%3d, inp_instn=%b, nextpc=%b, pc_to _branch=%b \n", $time, inp_instn, nextpc, pc_to_branch);
        inp_instn  = Imemory[pc/4];  //Was given to be [pc>>2]
        pc_to_branch = pc;
        nextpc <= pc+32'd4;             // pc value is not being updated, so the pc in next cycle will be the nextpc outpur received in this cycle
        
    end
always @ (pc)
    begin
    if (nextpc==32'd56)
        $finish;
    end

endmodule