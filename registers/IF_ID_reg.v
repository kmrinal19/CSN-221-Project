module IF_ID_reg(currpc, nextpc ,inp_instn ,out_instn ,clk ,PCplus4Out, currpc_out, reset);

  input wire [31:0] inp_instn,nextpc, currpc;
  input clk, reset;
  reg flag_if_id;
  output reg [31:0] out_instn, PCplus4Out, currpc_out;
  reg [31:0] t_inp_instn, t_nextpc, t_currpc;

  always @(posedge reset)
    begin
      flag_if_id = 1'b0;
    end
  always @(posedge clk)
    begin
        t_nextpc <= nextpc;
        t_currpc <= currpc;
        t_inp_instn = inp_instn;
        // $display("time = %3d IF ID: Ouput inst: %b", $time, out_instn);
    end

  always @(negedge clk)
    begin
        PCplus4Out <= t_nextpc;
        currpc_out <= t_currpc;
        out_instn = t_inp_instn;
        $display("time = %3d IF ID: Ouput inst: %b", $time, out_instn);
    end

endmodule
