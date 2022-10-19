module IF_ID_reg(currpc, nextpc ,inp_instn ,out_instn ,clk ,PCplus4Out, currpc_out);

  input wire [31:0] inp_instn,nextpc, currpc;
  input clk;
  output reg [31:0] out_instn, PCplus4Out, currpc_out;

  always @(posedge clk)
    begin
        out_instn <= inp_instn;
        PCplus4Out <= nextpc; 
        currpc_out <= currpc;
      #1
      $display ("time=%3d, inp_instn=%b, nextpc=%b, pc_to _branch=%b \n", $time, out_instn, PCplus4Out, currpc_out);

    end
  
endmodule
