`include "ALU.v"
`include "ALUControl.v"

module EX(clk, rs, rt, sign_ext, ALUSrc, ALUOp, funct, reset, pc);

input wire reset;        //To start from a known state - not necessary
input clk;
input wire [31:0] pc;
input wire branch;
input wire [31:0] rs;
input wire [31:0] rt;
input wire [31:0] sign_ext;
input wire ALUSrc;          //to choose bw rt and sign extend ,from cu
input wire [1:0] ALUOp;     //from cu
input wire [5:0] funct;     //from decode unit
wire [3:0] ALUControl;      
wire [31:0] result;
output wire zero, carry;
output reg [31:0] address;
reg offset;
// output reg [3:0] ALUControlOut;
output reg [31:0] resultOut;
output reg [31:0] pcout;



// wire [31:0] neg_data2 = -data2;
wire [31:0] data1 = rs;
reg [31:0] data2;

always @(ALUSrc)
begin
if(ALUSrc == 0)
data2 <= rt;
else
data2 <= sign_ext;  //assumed that 16-bit has been extended to 32-bit by ID unit
end

ALUControlUnit AC (.ALUOp (ALUOp),
    .funct (funct),
    .ALUControl (ALUControl)
);

ALUUnit A (
    .data1(data1), 
    .data2(data2), 
    .ALUControl(ALUControl), 
    .carry(carry), 
    .zero(zero), 
    .result(result), 
    .reset(reset)
);

always @(branch)
begin
    if (branch==1  && zero==0)
        offset = sign_ext<<2;
        address = offset + pc;
        pcout = address;
end


always@(posedge clk)
    begin
    
      resultOut<=result;
      
    end

endmodule