module Instruction_Memory(clk, pc, inp_instn, nextpc, pc_to_branch, reset);

input clk;
input wire reset;
input [31:0] pc;
reg [31:0] Imemory [0:1023];
output reg [31:0] inp_instn;
output reg [31:0] nextpc;
output reg [31:0] pc_to_branch;

initial //for testing
    begin
        $readmemb("IF_Unit/Icode.txt", Imemory);
    end


always @ (pc)
	#20

    begin
        inp_instn  = Imemory[pc];  //Was given to be [pc>>2]
        pc_to_branch = pc;
        nextpc <= pc+32'd4;             // pc value is not being updated, so the pc in next cycle will be the nextpc outpur received in this cycle
    end

endmodule