module Instruction_Memory(stall_flag, clk, pc, inp_instn, nextpc, pc_to_branch, reset);

input stall_flag;
input clk;
input wire reset;
input wire [31:0] pc;
// reg [31:0] pc_reg;
reg [31:0] Imemory [0:1023];
output reg [31:0] inp_instn;
output reg [31:0] nextpc;
output reg [31:0] pc_to_branch;

initial //for testing
    // #3
    begin
        $readmemb("Icode.txt", Imemory);
    end

always @ (posedge reset)
    // #3
    begin

        inp_instn  <= Imemory[0];
        nextpc <= 32'd4;
        pc_to_branch <= 32'd0;
        // #1
        $display ("time=%3d, inp_instn=%b, nextpc=%b, pc_to _branch=%b \n", $time, inp_instn, nextpc, pc_to_branch);

    end
always @ (posedge clk)
#20
    begin
    if (stall_flag==0)    
        begin
            
            inp_instn  = Imemory[pc/4];  //Was given to be [pc>>2]
            pc_to_branch <= pc;
            nextpc <= pc+32'd4;
              //enabling this leads to $readmemb: Unable to open Icode.txt for reading.
            // #1
            $display ("time=%3d, inp_instn=%b, nextpc=%b, pc_to _branch=%b \n", $time, inp_instn, nextpc, pc_to_branch);
            // pc value is not being updated, so the pc in next cycle will be the nextpc outpur received in this cycle
            
        end
    end
always @ (pc or clk)
    
    begin
    if (nextpc==32'd40)
        $finish;
    end

endmodule