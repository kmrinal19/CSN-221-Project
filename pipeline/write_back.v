// module Mem_Wb(MEM_WB_type, ALUResult, clk, Reg[MEM_WB_IR], loadData);

//     input clk, ALUResult, MEM_WB_type, loadData;
//     output Reg[MEM_WB_type];

//     always @ (posedge clk)
//         begin
//             case (MEM_WB_type) 
//                 rr_alu: 
//                     Reg[MEM_WB_IR[15:11]] <= ALUResult;
//                 rm_alu:
//                     Reg[MEM_WB_IR[20:16]] <= ALUResult;
//                 load:
//                     Reg[MEM_WB_IR[20:16]] <= loadData;
//             endcase
//         end
// endmodule

module WriteBack (mem_to_reg, alu_data_out, dm_data_out, clk, wb_data);
//todo: add reset
input mem_to_reg, clk;
input [31:0] alu_data_out, dm_data_out;
output reg [31:0] wb_data;

always @(posedge clk)
    begin
        if (mem_to_reg==1)
            wb_data <= dm_data_out;
        else
            wb_data <= alu_data_out;
    end
endmodule