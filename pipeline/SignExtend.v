module SignExtend(inp ,out);

input  [15:0] inp;
output [31:0] out;

assign out =  (inp[15] == 1)? {16'hffff , inp} : 
              (inp[15] == 0)? {16'h0000 ,inp}  : 16'hxxxx;

endmodule
