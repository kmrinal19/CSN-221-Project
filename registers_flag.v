module Registers_flag(clk, reset);

    input clk, reset;
	reg registers_flag[0:31];
    always @(posedge reset)
        begin
            registers_flag[0] <= 1'b0;
            registers_flag[1] <= 1'b0;
            registers_flag[2] <= 1'b0;
            registers_flag[3] <= 1'b0;
            registers_flag[4] <= 1'b0;
            registers_flag[5] <= 1'b0;
            registers_flag[6] <= 1'b0;
            registers_flag[7] <= 1'b0;
            registers_flag[8] <= 1'b0;
            registers_flag[9] <= 1'b0;
            registers_flag[10] <= 1'b0;
            registers_flag[11] <= 1'b0;
            registers_flag[12] <= 1'b0;
            registers_flag[13] <= 1'b0;
            registers_flag[14] <= 1'b0;
            registers_flag[15] <= 1'b0;
            registers_flag[16] <= 1'b0;
            registers_flag[17]<= 1'b0;
            registers_flag[18] <= 1'b0;
            registers_flag[19] <= 1'b0;
            registers_flag[20] <= 1'b0;
            registers_flag[21] <= 1'b0;
            registers_flag[22] <= 1'b0;
            registers_flag[23] <= 1'b0;
            registers_flag[24] <= 1'b0;
            registers_flag[25] <= 1'b0;
            registers_flag[26] <= 1'b0;
            registers_flag[27] <= 1'b0;
            registers_flag[28] <= 1'b0;
            registers_flag[29] <= 1'b0;
            registers_flag[30] <= 1'b0;
            registers_flag[31] <= 1'b0;
        end
endmodule