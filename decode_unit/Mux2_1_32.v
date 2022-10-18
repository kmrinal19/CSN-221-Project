// To be included as write_back stage
// module Mux2_1_5(inp1, inp2, cs, out);

// input [31:0] inp1, inp2;
// input cs;
// output [31:0] out;

// assign out = (cs == 1'b0) ? inp1: (cs == 1'b1)? inp2: 32'bx; // To understand: 32'bx

// endmodule