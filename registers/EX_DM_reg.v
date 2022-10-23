module EX_DM_register (
    ALU_result, mem_read_in, mem_write_in, Write_data_in, rd_in_ex_dm, Mem_address, mem_read_out_ex_dm, mem_write_out_ex_dm, Write_data_out, mem_to_reg_in, reg_write_in, mem_to_reg_out_ex_dm, reg_write_out_ex_dm, clk, reset, rd_out_ex_dm
);
input mem_to_reg_in, clk, reset;
input wire [4:0] rd_in_ex_dm;
input wire mem_read_in, mem_write_in, reg_write_in;
input wire [31:0] ALU_result, Write_data_in;
output reg mem_read_out_ex_dm, mem_write_out_ex_dm, reg_write_out_ex_dm;
output reg [31:0] Mem_address, Write_data_out;
output reg mem_to_reg_out_ex_dm;
output reg [4:0] rd_out_ex_dm;
reg flag_ex_dm;
always @(posedge reset)
    begin
      flag_ex_dm = 1'b1;
    end
always @(posedge clk)
    begin
        rd_out_ex_dm <= rd_in_ex_dm;
        mem_read_out_ex_dm <= mem_read_in;
        mem_write_out_ex_dm <= mem_write_in;
        Mem_address <= ALU_result;
        Write_data_out <= Write_data_in;
        mem_to_reg_out_ex_dm <= mem_to_reg_in;
        reg_write_out_ex_dm <= reg_write_in;
        // #1
        // $display("time=%3d, check address= %d \n",$time,rd_in_ex_dm);
    end

always@(posedge clk)
    $display("EX_DM", rd_out_ex_dm);
endmodule