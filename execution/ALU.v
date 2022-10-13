module ALUUnit(data1, data2, ALUControl, carry, zero, result, reset);

input wire reset;
input wire [31:0] data1;
input wire [31:0] data2;
input wire [3:0] ALUControl;
output reg [31:0] result;
output reg carry, zero;

wire [31:0] neg_data2 = -data2;   //for negative data


parameter ADD = 4'b0000;
parameter MUL = 4'b0010;
parameter SUB = 4'b0001;


always @(posedge reset) zero <= 1'b0;

always @(ALUControl or data1 or data2)
begin

if(data1 == data2)
zero <= 1'b1;
else
zero <= 1'b0;

case(ALUControl)

ADD: 
	begin	
	result <= data1 + data2;
	if(data1[31] == 1 && data2[31] == 1)
	carry <= 1'b1;
	else
	carry <= 1'b0;
	end
	//logic for carry

SUB:
	begin
	result <= data1 + neg_data2;
	if(data1[31] == 1 && neg_data2[31] == 1)
	carry <= 1'b1;
	else
	carry <= 1'b0;
	end
	
MUL:
	result <= data1 * data2;


endcase
end

endmodule