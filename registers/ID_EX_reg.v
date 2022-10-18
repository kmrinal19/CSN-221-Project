module ID_EX_reg (reg_write, mem_to_reg, mem_to_write, mem_read,alu_src, alu_op, nextpc ,reg_file_rd_data1 ,reg_file_rd_data2,sgn_ext_imm 
		,inst_imm_field ,nextpc_out ,reg_file_out_data1 ,reg_file_out_data2 ,sgn_ext_imm_out
		,mem_to_reg_out_id_ex,mem_write_out_id_ex, mem_read_out_id_ex,alu_src_out, alu_op_out, reg_dst_out,clk);
  
  input wire reg_write, mem_to_reg;
  input wire mem_to_write, mem_read; 
  input wire alu_src;
  input wire [1:0] alu_op;
  input wire [31:0] nextpc ,reg_file_rd_data1 ,reg_file_rd_data2 ,sgn_ext_imm;
  input wire [15:0] inst_imm_field;
  input wire clk;
  output reg mem_to_reg_out_id_ex;
  output reg mem_write_out_id_ex, mem_read_out_id_ex;
  output reg alu_src_out, reg_dst_out;
  output reg [1:0] alu_op_out;

  output reg [31:0] nextpc_out ,reg_file_out_data1 ,reg_file_out_data2 ,sgn_ext_imm_out;
  // output reg [4:0] rs_out ,rt_out;

  
  always @(posedge clk)
    begin
      nextpc_out <= nextpc;
      reg_file_out_data1 <= reg_file_rd_data1;
      reg_file_out_data2 <= reg_file_rd_data2;
      sgn_ext_imm_out <= sgn_ext_imm;
      // rs_out <= inst_imm_field[9:5];
      // rt_out <= inst_imm_field[14:10];
      // reg_write_out <= reg_write;
      mem_to_reg_out_id_ex <= mem_to_reg;
      mem_write_out_id_ex <= mem_to_write;
      mem_read_out_id_ex <= mem_read;
      alu_src_out <= alu_src;
      alu_op_out <= alu_op;
      // reg_dst_out <= reg_dst;
    end
  
endmodule
