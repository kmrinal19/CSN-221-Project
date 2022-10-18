module main(clk, rs, rt, sign_ext, ALUSrc, ALUOp, funct, branch, reset, pc, zero, address, resultOut, pcout);

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
reg [3:0] ALUControl;
reg [31:0] result;
output reg zero;
output reg [31:0] address;
output reg [31:0] resultOut;
output reg [31:0] pcout;
// output reg [3:0] ALUControlOut;

// wire [3:0] ALUControl;      
// wire [31:0] result;
reg offset;
// wire [31:0] neg_data2 = -data2;
wire [31:0] data1 = rs;
reg [31:0] data2;
// pcout = pc;

always @(ALUSrc)
#10
begin
if(ALUSrc == 0)
data2 <= rt;
else
data2 <= sign_ext;  //assumed that 16-bit has been extended to 32-bit by ID unit
end

//AluControl

parameter LW = 2'b00;
parameter SW = 2'b00;
parameter ADDI = 2'b00;
parameter BEQ = 2'b01;
parameter RType = 2'b10;
parameter ADD = 6'b000000;
parameter SUB = 6'b000001;
parameter MUL = 6'b000010;

always @* 
#10
begin
    pcout = pc;
case(ALUOp)

LW: //address always in rs and data in rt
begin
	ALUControl = 4'b0000;
    offset = sign_ext<<2; //check if shift is necessary
    data2 = offset;
end

SW:
begin
	ALUControl = 4'b0000;
    offset = sign_ext<<2; //check if shift is necessary
    data2 = offset;
end
ADDI:
	ALUControl = 4'b0000;

BEQ:
	ALUControl = 4'b0001;

RType:
    case(funct)

    ADD:
        ALUControl = 4'b0000;

    SUB:
        ALUControl = 4'b0001;

    MUL:
        ALUControl = 4'b0010;

    endcase


endcase

end

//ALU
// parameter ADD = 4'b0000;
// parameter MUL = 4'b0010;
// parameter SUB = 4'b0001;
always @(posedge reset) zero <= 1'b0;
always @(ALUControl or data1 or data2)
#10
begin

if(data1 == data2)
zero <= 1'b1;
else
zero <= 1'b0;

case(ALUControl)

4'b0000: 
	begin	
	result <= data1 + data2;
	end
	

4'b0010:
	begin
	result <= data1 - data2;
	end
	
4'b0011:
	begin
	result <= data1 * data2;
	end


endcase
end

always @(branch)
begin
    if (branch==1  && zero==1)
        offset = sign_ext<<2;
        address = offset + pc;
        pcout = address;
end


always@(posedge clk)
#10
    begin    
      resultOut<=result;      
    end

endmodule