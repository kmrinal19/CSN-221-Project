module DataMemory (stall_flag_dm_in, stall_flag_dm_out, Mem_address, Mem_read, Mem_write, Write_data, Read_Data, clk, reset);

reg [31:0] memory[0:9];
input stall_flag_dm_in;
input Mem_read, Mem_write, clk, reset;
input [31:0] Mem_address, Write_data;
output reg [31:0] Read_Data;
output reg stall_flag_dm_out;

always @(posedge reset)
    begin
        stall_flag_dm_out = stall_flag_dm_in;
        memory[0] <= 32'd4;
        memory[1] <= 32'd2;
        memory[2] <= 32'd3;
        memory[3] <= 32'd5;
        memory[4] <= 32'd7;
        memory[5] <= 32'd8;
        memory[6] <= 32'd9;
        memory[7] <= 32'd0;
        memory[8] <= 32'd1;
        memory[9] <= 32'd4;
    end

always @(Mem_read) 
//   #10
    #1
    begin
    if(stall_flag_dm_in==0)
    begin
        if(Mem_read==1)
            Read_Data <= memory[Mem_address];
    end
    end

always @(negedge clk)
//   #10
    #1
    begin
    if(stall_flag_dm_in==0)
    begin
        if(Mem_write==1)
            memory[Mem_address] <= Write_data;
    end
    end
    
endmodule