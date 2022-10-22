`timescale 1ns / 1ps
`include "RegisterFile.v"

module testb;
    reg [4:0] inst_read_reg_addr1 ,inst_read_reg_addr2 ,reg_wr_addr;
	reg [31:0] reg_wr_data;
	reg reg_wr ,clk, reset;
	wire [31:0] reg_file_rd_data1 ,reg_file_rd_data2;

    RegisterFile tb (
        inst_read_reg_addr1, inst_read_reg_addr2, reg_wr_addr, reg_wr_data, reg_wr, clk, reg_file_rd_data1, reg_file_rd_data2, reset
    );

    initial 
    begin
        clk = 1'b0;
        forever #1 clk = ~clk;
    end

    initial 
    begin
        reset = 1'b1;
        #500 reset = 1'b0;
    end

    initial 
    begin
        #20
        inst_read_reg_addr1 = 5'd5;
        inst_read_reg_addr2 = 5'd6;
        reg_wr_addr = 5'd7;
        reg_wr_data = 32'd20;
        reg_wr = 1'b1;
        #40
        $display ("time=%3d, reg_file_rd_data1=%b ,reg_file_rd_data2=%b \n", $time,reg_file_rd_data1 ,reg_file_rd_data2);

        #10
        inst_read_reg_addr1 = 5'd4;
        inst_read_reg_addr2 = 5'd7;
        reg_wr_addr = 5'd7;
        reg_wr_data = 32'd32;
        reg_wr = 1'b0;
        #40
        $display ("time=%3d, reg_file_rd_data1=%b ,reg_file_rd_data2=%b \n", $time,reg_file_rd_data1 ,reg_file_rd_data2);

        inst_read_reg_addr1 = 5'd4;
        inst_read_reg_addr2 = 5'd7;
        reg_wr_addr = 5'd7;
        reg_wr_data = 32'd20;
        reg_wr = 1'b0;
        #40
        $display ("time=%3d, reg_file_rd_data1=%b ,reg_file_rd_data2=%b \n", $time,reg_file_rd_data1 ,reg_file_rd_data2);
      	// $finish;

        

    end

endmodule
