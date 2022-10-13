module Mux2_1_5(inp1, inp2, cs, out);

input [4:0] inp1, inp2;
input cs;
output [4:0] out;

assign reg_write_addr = (cs == 1'b0) ?
        inp1: (cs == 1'b1)? inp2: 5'bx;

endmodule