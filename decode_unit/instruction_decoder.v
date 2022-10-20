`include "decode_unit/Mux2_1_5.v"
`include "registers_flag.v"
// `include "decode_unit/Mux2_1_32.v"
`include "decode_unit/RegisterFile.v"
`include "decode_unit/SignExtend.v"
//`include "decode_unit/LeftShift2.v"

module instruction_decoder (
    clk,
    reset,
    inst_read_reg_addr1,
    inst_read_reg_addr2,
    // rt removed (Redundant input, same as inst_read_reg_addr2)
    rd,
    reg_wr_data, // Added reg_wr_data
    // alu_data_out removed (Redundant, to be included in WB stage)
    // mem_data_out removed (Redundant, to be included in WB stage)
    inst_imm_field,
    reg_dst,
    reg_write,
    // mem_to_reg removed (Redundant, to be included in WB stage)
    // jr_offset removed (What is jr_offset?)
    reg_file_rd_data1,
    reg_file_rd_data2,
    imm_field_wo_sgn_ext, // wo: without
    sgn_ext_imm,
    imm_sgn_ext_lft_shft,
    rd_out_id
);
    input clk, reset, reg_write;
    input [4:0] inst_read_reg_addr1 ,inst_read_reg_addr2, rd; //rt removed
    // input [31:0] alu_data_out, mem_data_out; (Redundant, to be included in WB stage)
    input [15:0] inst_imm_field;
    input [31:0] reg_wr_data; // Added reg_wr_data
    input reg_dst; // mem_to_reg removed(Redundant mem_to_reg signal, to be included in WB stage)
    output [31:0] reg_file_rd_data1, reg_file_rd_data2, sgn_ext_imm, imm_sgn_ext_lft_shft;
    output reg [15:0] imm_field_wo_sgn_ext;
    output reg [4:0] rd_out_id;
    // computing multiplexer results
    wire [4:0] reg_wr_addr; // Changed reg to wire due to error in line 37
    // reg [31:0] reg_wr_data; (removed calculation of reg_wr_data)
    Mux2_1_5 reg_wr_mux(inst_read_reg_addr2, rd, reg_dst, reg_wr_addr);
    // Mux2_1_32 wrb_mux(alu_data_out, mem_data_out, mem_to_reg, reg_wr_data);
    //#1
    // register file
    RegisterFile registerFile(inst_read_reg_addr1, inst_read_reg_addr2, reg_wr_addr, reg_wr_data, reg_write, clk, reg_file_rd_data1, reg_file_rd_data2, reset);

    // sign extension
    SignExtend signExtend(inst_imm_field, sgn_ext_imm);

    // left shift
    //#1
    assign imm_sgn_ext_lft_shft = sgn_ext_imm << 2;

    // always @(reg_file_rd_data1) begin
    //     jr_offset <= reg_file_rd_data1;
    // end

    // assign imm_field_wo_sgn_ext = inst_imm_field; //Added below block in place

    always @(inst_imm_field) begin
        imm_field_wo_sgn_ext <= inst_imm_field;
    end
    // always @(posedge clk)
    // begin
    //     rd_out_id <= reg_wr_addr;
    // end
    always @(negedge clk)
    begin
        rd_out_id <= reg_wr_addr;
        if (reg_write==1)
            Registers_flag.registers_flag[rd] <= 1'b1;
    end

endmodule