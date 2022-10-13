module instruction_decoder (
    inst_read_reg_addr1,
    inst_read_reg_addr2,
    rt,
    rd,
    alu_data_out,
    mem_data_out,
    inst_imm_field,
    reg_dst,
    mem_to_reg,
    jr_offset,
    reg_file_rd_data1,
    reg_file_rd_data2,
    imm_field_wo_sgn_ext,
    sgn_ext_imm,
    imm_sgn_ext_lft_shft
);

    input [4:0] inst_read_reg_addr1 ,inst_read_reg_addr2, rt, rd;
    input [31:0] alu_data_out, mem_data_out;
    input [15:0] inst_imm_field;
    input reg_dst, mem_to_reg;
    output [31:0] jr_offset, reg_file_rd_data1, reg_file_rd_data2, sgn_ext_imm, imm_sgn_ext_lft_shft;
    output [15:0] imm_field_wo_sgn_ext;

    // computing multiplexor results
    reg [4:0] reg_wr_addr;
    reg [31:0] reg_wr_data;
    Mux2_1_5 reg_wr_mux(rt, rd, reg_dst, reg_wr_addr);
    Mux2_1_32 wrb_mux(alu_data_out, mem_data_out, mem_to_reg, reg_wr_data);

    // register file
    RegisterFile regiterFile(inst_read_reg_addr1, inst_read_reg_addr2, reg_wr_addr, reg_wr_data, reg_wr, clk, reg_file_rd_data1, reg_file_rd_data2);

    // sign extension
    SignExtend signExtend(inst_imm_field, sgn_ext_imm);

    // left shift
    LeftShift2 left_shift(sgn_ext_imm, imm_sgn_ext_lft_shft);

    always @(reg_file_rd_data1) begin
        jr_offset <= reg_file_rd_data1;
    end

    always @(inst_imm_field) begin
        imm_field_wo_sgn_ext <= inst_imm_field;
    end
    
endmodule