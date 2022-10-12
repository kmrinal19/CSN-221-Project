//This code is redundant
//All functionalities implemented in Instruction_Memory


`include "Instruction_Memory_1.v"

module IF(instruction_out, nextpc, instruction, pc);

input wire [31:0] instruction;
input wire [31:0] pc;

output reg instruction_out;
output reg [31:0] nextpc;

always @ (pc)

    begin
        instruction_out <= instruction;
        nextpc <= pc+4;
    end

endmodule