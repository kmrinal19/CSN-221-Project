
module WriteBack (rd_in_wb, reg_write, mem_to_reg, alu_data_out, dm_data_out, clk, wb_data, reset, reg_write_out_wb, rd_out_wb);
//todo: add reset
input mem_to_reg, clk, reset, reg_write;
input [31:0] alu_data_out, dm_data_out;
input wire [4:0] rd_in_wb;
integer i;
output reg [31:0] wb_data;
output reg reg_write_out_wb;
output reg [4:0] rd_out_wb;

always @(posedge clk)
    begin
        rd_out_wb <= rd_in_wb;
        reg_write_out_wb <= reg_write;
        if (mem_to_reg==1)
            wb_data <= dm_data_out;
        else
            wb_data <= alu_data_out;
    end

    always @(negedge clk)
	// if (stall_flag==0)
	// begin
	// #8
	#1
		begin
			if (reg_write == 1)
				begin
					RegisterFileGlb.registers[rd_out_wb] = wb_data;
					RegisterFileGlb.registers_flag[rd_out_wb] = 1'b0;
					#1
					$display ("time=%3d, ans=%b addr=%b data=%b \n", $time, RegisterFileGlb.registers[rd_out_wb], rd_out_wb,wb_data);
				end
		end
	// end
	always@(posedge clk)
	begin
		for(i=0; i<32; i=i+1)
			$display("Register ", i , " ", RegisterFileGlb.registers[i]);
	end

    always@(posedge clk)
    $display("Writeback ", rd_out_wb, " ", wb_data);
endmodule