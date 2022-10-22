
module WriteBack (rd_in_wb, reg_write, mem_to_reg, alu_data_out, dm_data_out, clk, wb_data, reset, reg_write_out_wb, rd_out_wb);
//todo: add reset
input mem_to_reg, clk, reset, reg_write;
input [31:0] alu_data_out, dm_data_out;
input wire [4:0] rd_in_wb;
output reg [31:0] wb_data;
output reg reg_write_out_wb;
output reg [4:0] rd_out_wb;

always @(posedge clk)
// #2
    begin
        rd_out_wb = rd_in_wb;
        reg_write_out_wb = reg_write;
        // #1
        if (mem_to_reg==0)
            wb_data = alu_data_out;
            
            
        else
            wb_data = dm_data_out;
        
        $display("data ", wb_data, "address ", rd_out_wb);
        // rd_out_wb = rd_in_wb;
    end
endmodule