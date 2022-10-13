module Instruction_Memory(clk, pc, out_instn);

input clk;
input [31:0] pc;
reg [31:0] Imemory [0:1023];
output reg [31:0] out_instn;
output reg [31:0] nextpc;
output reg [31:0] pc_to_branch;

initial //for testing
    begin
        $readmemh("Icode.txt", Imemory);
    end


always @ (pc)

    begin
        out_instn  <= Imemory[pc];  //Was given to be [pc>>2]
        pc_to_branch <= pc;
        nextpc <= pc+4;             // pc value is not being updated, so the pc in next cycle will be the nextpc outpur received in this cycle
    end


endmodule