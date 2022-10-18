module RegisterFile(inst_read_reg_addr1, inst_read_reg_addr2, reg_wr_addr, reg_wr_data, reg_wr, clk, reg_file_rd_data1, reg_file_rd_data2);

	input [4:0] inst_read_reg_addr1 ,inst_read_reg_addr2 ,reg_wr_addr;
	input [31:0] reg_wr_data;
	input reg_wr ,clk;
	output reg [31:0] reg_file_rd_data1 ,reg_file_rd_data2;

	reg [31:0] registers[0:31]; // Need to understand implementation of 32 32-bit registers
    // Todo :: read only at pos edge
	always @(inst_read_reg_addr1, inst_read_reg_addr2)
		begin
			reg_file_rd_data1 <= registers[inst_read_reg_addr1];
			reg_file_rd_data2 <= registers[inst_read_reg_addr2];
		end

	always @(negedge clk)
		begin
			if (reg_wr == 1)
				begin
					registers[reg_wr_addr] <= reg_wr_data;
				end
		end

endmodule
