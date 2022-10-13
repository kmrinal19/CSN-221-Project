module ALUControlUnit(ALUControl, ALUOp, funct);


// input clk;
input wire [1:0] ALUOp;
input wire [5:0] funct;
output reg [3:0] ALUControl;

parameter LW = 2'b00;
parameter SW = 2'b00;
parameter BEQ = 2'b01;
parameter RType = 2'b10;
parameter ADD = 6'b000000;
parameter SUB = 6'b000001;
parameter MUL = 6'b000010;


always @* begin
case(ALUOp)

LW: 
	ALUControl = 4'b0000;

SW:
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

endmodule