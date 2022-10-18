module LeftShift2(out, inp);

input [31:0] inp;
output [31:0] out;

assign out = inp << 2;

endmodule
