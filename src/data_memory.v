module DataMemory (
    Mem_address, Mem_read, Mem_write, Write_data, Read_Data, clk
);

reg [31:0] memory[0:31];

input Mem_read, Mem_write, clk;
input [31:0] Mem_address, Write_data;
output reg [31:0] Read_Data;

always @(Mem_read) 
    begin
        if(Mem_read==1)
            Read_Data <= memory[Mem_address];
    end

always @(negedge clk)
    begin
        if(Mem_write==1)
            memory[Mem_address] <= Write_data;
    end
    
endmodule