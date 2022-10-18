module MEM_WB_reg(mem_to_reg,alu_result,clk,read_data,mem_to_reg_out_dm_wb,read_data_out,alu_res_out);
  
  input clk;
  input mem_to_reg;
  // input [4:0] write_reg;
  input [31:0] alu_result, read_data;
  output reg mem_to_reg_out_dm_wb;
  output reg [31:0] read_data_out,alu_res_out;
  // output reg [4:0] write_reg_out;
  
  always@(posedge clk)
    begin
      // reg_write_out<=reg_write;
      mem_to_reg_out_dm_wb<=mem_to_reg;
      read_data_out<=read_data;
      alu_res_out<=alu_result;
      // write_reg_out<=write_reg; 
      
    end
  
  
endmodule