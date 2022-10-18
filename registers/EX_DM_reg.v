module EX_DM_register (
    ALU_result, Mem_read_in, Mem_write_in, Write_data_in, Mem_address, Mem_read_out, Mem_write_out, Write_data_out, clk, mem_to_reg_in, mem_to_reg_out_ex_dm
);
input mem_to_reg_in, clk;
input wire Mem_read_in, Mem_write_in;
input wire [31:0] ALU_result, Write_data_in;
output reg Mem_read_out, Mem_write_out;
output reg [31:0] Mem_address, Write_data_out;
output reg mem_to_reg_out_ex_dm;

always @(posedge clk)
    begin
        Mem_read_out <= Mem_read_in;
        Mem_write_out <= Mem_write_in;
        Mem_address <= ALU_result;
        Write_data_out <= Write_data_in;
        mem_to_reg_out_ex_dm <= mem_to_reg_in;
    end
endmodule