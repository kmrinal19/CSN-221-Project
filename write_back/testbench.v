`timescale 1ns / 1ps
`include "write_back.v"

module wb_tb();
    reg mem_to_reg, clk;
    reg [31:0] alu_data_out, dm_data_out, wb_data;


// instantiate testbench
WriteBack tb (
    .clk (clk),
    .mem_to_reg (mem_to_reg),
    .alu_data_out (alu_data_out),
    .dm_data_out (dm_data_out),
    .wb_data (wb_data)
);


initial begin
    clk = 1'b0;
    forever
        #1 clk = ~clk;
end
  
initial begin   
    mem_to_reg = 0;
    alu_data_out = 5;
    dm_data_out = 4;
	#30
    $display("wb_data=%d", wb_data);
    $finish;

end

endmodule