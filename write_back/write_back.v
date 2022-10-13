module Mem_Wb(MEM_WB_type, ALUResult, clk, Reg[MEM_WB_IR], loadData);

    input clk, ALUResult, MEM_WB_type, loadData;
    output Reg[MEM_WB_type];

    always @ (posedge clk)
        begin
            case (MEM_WB_type) 
                rr_alu: 
                    Reg[MEM_WB_IR[15:11]] <= ALUResult;
                rm_alu:
                    Reg[MEM_WB_IR[20:16]] <= ALUResult;
                load:
                    Reg[MEM_WB_IR[20:16]] <= loadData;
            endcase
        end
endmodule