`timescale 1ns / 1ps
`include "IF_Unit/Instruction_Memory.v"
`include "execution/EX.v"
`include "data_memory/data_memory.v"
`include "write_back/write_back.v"
`include "registers/IF_ID_reg.v"
`include "registers/ID_EX_reg.v"
`include "registers/EX_DM_reg.v"
`include "registers/DM_WB_reg.v"
`include "decode_unit/controlunit.v"
`include "decode_unit/instruction_decoder.v"


module pipeline;
    reg clk;
    wire mem_to_reg_out_ex_dm;
	reg reset;
    wire [31:0] pc;
    reg [31:0] Imemory [0:1023];
    wire [31:0] inp_instn;
    wire [31:0] nextpc;
    wire [31:0] pc_to_branch;
    wire [31:0] PCplus4Out;
    wire [31:0] currpc_out;
    wire [31:0] out_instn;
    wire [5:0] opcode;
    wire [4:0] inst_read_reg_addr1, inst_read_reg_addr2, rd;
    wire [15:0] inst_imm_field;
    wire [1:0] alu_op;
    wire [5:0] funct;
    wire [31:0] branch_address; 
    wire [31:0] pcout, resultOut, Mem_address, Write_data;
    wire Mem_read, Mem_write, mem_to_reg_out_dm_wb; 
    wire [31:0] Read_Data, read_data_out_wb, alu_res_out_wb;

    


    Instruction_Memory IM (
        .clk(clk),
        .pc(pc),
      	.reset(reset),
        .inp_instn(inp_instn),
        .nextpc(nextpc),
        .pc_to_branch(pc_to_branch)
    );

    IF_ID_reg IF(
        .currpc(pc_to_branch),
        .inp_instn(inp_instn),
        .nextpc(nextpc),
        .PCplus4Out(PCplus4Out),
        .currpc_out(currpc_out),
        .out_instn(out_instn)
    );



    assign opcode = inp_instn[31:26]; // changes to be made in controlunit.v
    assign inst_read_reg_addr1 = inp_instn[25:21];
    assign inst_read_reg_addr2 = inp_instn[20:16];
    assign rd = inp_instn[15:11];
    assign inst_imm_field = inp_instn[15:0];
    assign funct = inp_instn[5:0];
    
    ControlUnit cu (
        .opcode(opcode),
        .reset(reset),
        .reg_dst(reg_dst),
        .branch(branch),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write)
        );
    
    wire [31:0] reg_wr_data;
    // reg_dst and reg_write
    wire [31:0] reg_file_rd_data1, reg_file_rd_data2, sgn_ext_imm, imm_sgn_ext_lft_shft;
    wire [15:0] imm_field_wo_sgn_ext; 
    wire [31:0] nextpc_out;
    wire [31:0] reg_file_out_data1, reg_file_out_data2;
    wire [31:0] sgn_ext_imm_out;
    wire [4:0] rs_out, rt_out;
    wire [1:0] alu_op_out;
    
    instruction_decoder tb (
        .clk (clk),
        .reset(reset),
        .inst_read_reg_addr1(inst_read_reg_addr1),
        .inst_read_reg_addr2(inst_read_reg_addr2),
        .rd(rd),
        .reg_wr_data(reg_wr_data),
        .inst_imm_field(inst_imm_field),
        .reg_dst(reg_dst),
        .reg_write(reg_write),
        .reg_file_rd_data1(reg_file_rd_data1),
        .reg_file_rd_data2(reg_file_rd_data2),
        .imm_field_wo_sgn_ext(imm_field_wo_sgn_ext),
        .sgn_ext_imm(sgn_ext_imm),
        .imm_sgn_ext_lft_shft(imm_sgn_ext_lft_shft)
    );

    ID_EX_reg ID_EX (
        reg_write, mem_to_reg, mem_to_write, mem_read,alu_src, alu_op, nextpc ,reg_file_rd_data1 ,reg_file_rd_data2,sgn_ext_imm 
		,inst_imm_field ,nextpc_out ,reg_file_out_data1 ,reg_file_out_data2 ,sgn_ext_imm_out
		,mem_to_reg_out_id_ex, mem_write_out_id_ex, mem_read_out_id_ex,alu_src_out, alu_op_out, reg_dst_out,clk
    );

    EX Ex (
        .clk (clk),
        .reset (reset),
        .rs (reg_file_out_data1),
        .rt (reg_file_out_data2),
        .sign_ext (sgn_ext_imm_out),
        .ALUSrc (alu_src_out),
        .ALUOp (alu_op_out),
        .funct (funct),
        .pc (pc),
        .address(branch_address),
        .zero (zero),
        .resultOut(resultOut),
        .pcout (pcout), // redundant
      	.branch (branch)
    );
    
    EX_DM_register EX_DM (
        .ALU_result (resultOut),
        .mem_to_reg_in(mem_to_reg_out_id_ex),
        .mem_to_reg_out_ex_dm(mem_to_reg_out_ex_dm),
        .Mem_read_in (Mem_read_out), // change variable's name
        .Mem_write_in(Mem_write_out), // change variable's name
        .Write_data_in(reg_file_out_data2),
        .Mem_address(Mem_address), 
        .Mem_read_out(mem_read_out_id_ex), 
        .Mem_write_out(mem_write_out_id_ex), 
        .Write_data_out(Write_data), 
        .clk(clk)
    );

    DataMemory DM (
        .clk(clk),
        .reset(reset),
        .Mem_read(Mem_read_out),
        .Mem_write(Mem_write_out),
        .Mem_address(Mem_address),
        .Write_data(Write_data),
        .Read_Data(Read_Data)
    );

    MEM_WB_reg DM_WB (
        .clk(clk),
        .alu_result(resultOut),
        .read_data(Read_Data),
        .mem_to_reg(mem_to_reg_out_ex_dm),
        .mem_to_reg_out_dm_wb(mem_to_reg_out_dm_wb),
        .read_data_out(read_data_out_wb),
        .alu_res_out(alu_res_out_wb)
    );

    WriteBack WB(
        .clk(clk),
        .mem_to_reg(mem_to_reg_out_dm_wb),
        .alu_data_out(alu_res_out_wb),
        .dm_data_out(read_data_out_wb),
        .wb_data(reg_wr_data)
    );
    



    
endmodule