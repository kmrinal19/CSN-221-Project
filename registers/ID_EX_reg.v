module ID_EX_reg (branch, reg_write, mem_to_reg, mem_write, mem_read, rd_in_id_ex, alu_src, alu_op, nextpc ,reg_file_rd_data1,reg_file_rd_data2, sgn_ext_imm, inst_imm_field, nextpc_out, reg_file_out_data1, reg_file_out_data2, sgn_ext_imm_out, reg_write_out_id_ex, mem_to_reg_out_id_ex, mem_write_out_id_ex, mem_read_out_id_ex, branch_out_id_ex, alu_src_out_id_ex, alu_op_out_id_ex, clk, reset, rd_out_id_ex);


  input wire reg_write, mem_to_reg, branch;
  input wire [4:0] rd_in_id_ex;
  input wire mem_write, mem_read;
  input wire alu_src;
  input wire [1:0] alu_op;
  input wire [31:0] nextpc ,reg_file_rd_data1 ,reg_file_rd_data2 ,sgn_ext_imm;
  input wire [15:0] inst_imm_field;
  input wire clk, reset;
  output reg reg_write_out_id_ex, mem_to_reg_out_id_ex, branch_out_id_ex;
  output reg mem_write_out_id_ex, mem_read_out_id_ex;
  output reg alu_src_out_id_ex;
  output reg [1:0] alu_op_out_id_ex;
  output reg [4:0] rd_out_id_ex;


  output reg [31:0] nextpc_out ,reg_file_out_data1 ,reg_file_out_data2 ,sgn_ext_imm_out;
  reg flag_id_ex;
  // output reg [4:0] rs_out ,rt_out;

  always @(posedge reset)
    begin
      flag_id_ex = 1'b1;
    end
  always @(posedge clk)
    begin
      nextpc_out <= nextpc;
      branch_out_id_ex <= branch;
      reg_file_out_data1 <= reg_file_rd_data1;
      reg_file_out_data2 <= reg_file_rd_data2;
      sgn_ext_imm_out <= sgn_ext_imm;
      rd_out_id_ex <= rd_in_id_ex;
      // rs_out <= inst_imm_field[9:5];
      // rt_out <= inst_imm_field[14:10];
      // reg_write_out <= reg_write;
      reg_write_out_id_ex <= reg_write;
      mem_to_reg_out_id_ex <= mem_to_reg;
      mem_write_out_id_ex <= mem_write;
      mem_read_out_id_ex <= mem_read;
      alu_src_out_id_ex <= alu_src;
      alu_op_out_id_ex <= alu_op;
      // reg_dst_out <= reg_dst;
    end

endmodule
