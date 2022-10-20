module RegisterFile(inst_read_reg_addr1, inst_read_reg_addr2, reg_wr_addr, reg_wr_data, reg_wr, clk, reg_file_rd_data1, reg_file_rd_data2, reset);

	input [4:0] inst_read_reg_addr1 ,inst_read_reg_addr2 ,reg_wr_addr;
	input [31:0] reg_wr_data;
	input reg_wr ,clk, reset;
	output reg [31:0] reg_file_rd_data1 ,reg_file_rd_data2;

	reg [31:0] registers[0:31]; // Need to understand implementation of 32 32-bit registers
	//TODO: Reading at posedge makes the program inefficient

	always @(reset)
		begin
			registers[0] <= 32'd0;
			registers[1] <= 32'd0;
			registers[2] <= 32'd0;
			registers[3] <= 32'd0;
			registers[4] <= 32'd4;
			registers[5] <= 32'd5;
			registers[6] <= 32'd6;
			registers[7] <= 32'd7;
			registers[8] <= 32'd0;
			registers[9] <= 32'd0;
			registers[10] <= 32'd0;
			registers[11] <= 32'd0;
			registers[12] <= 32'd0;
			registers[13] <= 32'd0;
			registers[14] <= 32'd0;
			registers[15] <= 32'd0;
			registers[16] <= 32'd0;
			registers[17] <= 32'd0;
			registers[18] <= 32'd0;
			registers[19] <= 32'd0;
			registers[20] <= 32'd0;
			registers[21] <= 32'd0;
			registers[22] <= 32'd0;
			registers[23] <= 32'd0;
			registers[24] <= 32'd0;
			registers[25] <= 32'd0;
			registers[26] <= 32'd0;
			registers[27] <= 32'd0;
			registers[28] <= 32'd0;
			registers[29] <= 32'd0;
			registers[30] <= 32'd0;
			registers[31] <= 32'd0;
		end
	always @(inst_read_reg_addr1, inst_read_reg_addr2, posedge clk)
		begin
			reg_file_rd_data1 <= registers[inst_read_reg_addr1];
			reg_file_rd_data2 <= registers[inst_read_reg_addr2];
		end

    always@(reg_wr_data) $display("reg_wr_data =%d",reg_wr_data);

	always @(negedge clk)
	#8
		begin
			if (reg_wr == 1)
				begin
					registers[reg_wr_addr] = reg_wr_data;
					// #1
					// $display ("time=%3d, ans=%b addr=%b data=%b\n", $time, registers[1], reg_wr_addr,reg_wr_data);
				end
		end

endmodule
