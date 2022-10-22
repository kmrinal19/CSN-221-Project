module MEM_WB_reg(mem_to_reg, reg_write, rd_in_dm_wb, alu_result, clk, read_data, mem_to_reg_out_dm_wb, reg_write_out_dm_wb, read_data_out, alu_res_out,reset, rd_out_dm_wb);

  input clk, reset;
  input wire [4:0] rd_in_dm_wb;
  input mem_to_reg, reg_write;
  // input [4:0] write_reg;
  input [31:0] alu_result, read_data;
  output reg mem_to_reg_out_dm_wb, reg_write_out_dm_wb;
  output reg [31:0] read_data_out,alu_res_out;
  output reg [4:0] rd_out_dm_wb;
  // output reg [4:0] write_reg_out;
  reg flag_dm_wb;
  always @(posedge reset)
    begin
      flag_dm_wb = 1'b1;
    end
  always@(posedge clk)
  
    begin
      // reg_write_out<=reg_write;
      mem_to_reg_out_dm_wb <= mem_to_reg;
      reg_write_out_dm_wb <= reg_write;
      read_data_out <= read_data;
      alu_res_out <= alu_result;
      // #2
      rd_out_dm_wb <= rd_in_dm_wb;

      // write_reg_out<=write_reg;

    end


endmodule