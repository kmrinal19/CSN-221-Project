module RegisterFileGlb();
	integer i;
	reg [31:0] registers[0:31];
	reg registers_flag[0:31];

	initial
		begin
			registers[0] <= 32'd0; registers_flag[0] <= 32'd0;
			registers[1] <= 32'd0; registers_flag[1] <= 32'd0;
			registers[2] <= 32'd0; registers_flag[2] <= 32'd0;
			registers[3] <= 32'd0; registers_flag[3] <= 32'd0;
			registers[4] <= 32'd4; registers_flag[4] <= 32'd0;
			registers[5] <= 32'd5; registers_flag[5] <= 32'd0;
			registers[6] <= 32'd6; registers_flag[6] <= 32'd0;
			registers[7] <= 32'd7; registers_flag[7] <= 32'd0;
			registers[8] <= 32'd0; registers_flag[8] <= 32'd0;
			registers[9] <= 32'd0; registers_flag[9] <= 32'd0;
			registers[10] <= 32'd0; registers_flag[10] <= 32'd0;
			registers[11] <= 32'd0; registers_flag[11] <= 32'd0;
			registers[12] <= 32'd0; registers_flag[12] <= 32'd0;
			registers[13] <= 32'd0; registers_flag[13] <= 32'd0;
			registers[14] <= 32'd0; registers_flag[14] <= 32'd0;
			registers[15] <= 32'd15; registers_flag[15] <= 32'd0;
			registers[16] <= 32'd16; registers_flag[16] <= 32'd0;
			registers[17] <= 32'd0; registers_flag[17] <= 32'd0;
			registers[18] <= 32'd0; registers_flag[18] <= 32'd0;
			registers[19] <= 32'd0; registers_flag[19] <= 32'd0;
			registers[20] <= 32'd0; registers_flag[20] <= 32'd0;
			registers[21] <= 32'd0; registers_flag[21] <= 32'd0;
			registers[22] <= 32'd0; registers_flag[22] <= 32'd0;
			registers[23] <= 32'd0; registers_flag[23] <= 32'd0;
			registers[24] <= 32'd0; registers_flag[24] <= 32'd0;
			registers[25] <= 32'd0; registers_flag[25] <= 32'd0;
			registers[26] <= 32'd0; registers_flag[26] <= 32'd0;
			registers[27] <= 32'd0; registers_flag[27] <= 32'd0;
			registers[28] <= 32'd0; registers_flag[28] <= 32'd0;
			registers[29] <= 32'd0; registers_flag[29] <= 32'd0;
			registers[30] <= 32'd0; registers_flag[30] <= 32'd0;
			registers[31] <= 32'd0; registers_flag[31] <= 32'd0;
		end

	
	

    // always@(reg_wr_data, reg_wr_addr) $display("reg_wr_data =%d, reg_wr_addr=%d",reg_wr_data, reg_wr_addr);

	

endmodule
