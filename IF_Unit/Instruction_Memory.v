module Instruction_Memory(stall_flag, clk, inp_instn, reset, stall_flag_out);

input stall_flag;
input clk;
input wire reset;
// reg [31:0] pc_reg;
// reg confirm;
reg [31:0] Imemory [0:1023];
output reg [31:0] inp_instn;
// output reg [31:0] nextpc;
// output reg [31:0] pc_to_branch;
output reg stall_flag_out;

initial //for testing
    begin
        $readmemb("m.bin", Imemory);
        // stall_flag = 1'b0;
        // confirm = 1'b1;
    end

// always @ (posedge reset)
//     begin
//         // confirm = 1'b1;
//         inp_instn  <= Imemory[0];
//         // nextpc <= 32'd4;
//         pc_to_branch <= 32'd0;
//         stall_flag_out <= stall_flag;
//         #1
//         $display ("time=%3d, inp_instn=%b, nextpc=%b, pc_to _branch=%b \n", $time, inp_instn, nextpc, pc_to_branch);

//     end
always @ (PC.pc or stall_flag or posedge clk)
begin
    stall_flag_out <= stall_flag;
    $display("Vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv", stall_flag_out);
    if (stall_flag==0)
    begin
        // confirm = 1'b0;
        
            #20  //enabling this leads to $readmemb: Unable to open Icode.txt for reading.
            // #1
            $display ("time=%3d, inp_instn=%b, pc,\n", $time, inp_instn, PC.pc);
            inp_instn  = Imemory[PC.pc/4];  //Was given to be [pc>>2]
            // pc_to_branch = PC.pc;
            PC.pc = PC.pc+4;             // pc value is not being updated, so the pc in next cycle will be the nextpc outpur received in this cycle
             $display("if flag", stall_flag);
        end
    end
always @ (PC.pc)
    begin
    if (PC.pc==32'd60)
        $finish;
    end

endmodule