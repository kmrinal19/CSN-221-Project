`include "decode_unit/Mux2_1_5.v"
// `include "registers_flag.v"
// `include "decode_unit/Mux2_1_32.v"
// `include "decode_unit/RegisterFile.v"
`include "decode_unit/SignExtend.v"
//`include "decode_unit/LeftShift2.v"

module instruction_decoder (
    stall_flag_id_in,
    // stall_flag_if,
    // stall_flag_ex,
    stall_flag_id_out,
    // stall_flag_if_out,
    // stall_flag_ex_out,
    reg_write_cu,
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
    rd_out_id,
    reg_wr_addr_wb
);
  
    input clk, reset, reg_write, stall_flag_id_in;
    input [4:0] inst_read_reg_addr1 ,inst_read_reg_addr2, rd, reg_wr_addr_wb; //rt removed
    // input [31:0] alu_data_out, mem_data_out; (Redundant, to be included in WB stage)
    input [15:0] inst_imm_field;
    input [31:0] reg_wr_data; // Added reg_wr_data
    input reg_dst, reg_write_cu; // mem_to_reg removed(Redundant mem_to_reg signal, to be included in WB stage)
    output reg [31:0] reg_file_rd_data1, reg_file_rd_data2;
    output wire [31:0] sgn_ext_imm, imm_sgn_ext_lft_shft;
    output reg [15:0] imm_field_wo_sgn_ext;
    output reg [4:0] rd_out_id;
    output reg stall_flag_id_out;
    
    // computing multiplexer results
    wire [4:0] reg_wr_addr; // Changed reg to wire due to error in line 37
    // reg [4:0] reg_wr_addr; 
    // reg [31:0] reg_wr_data; (removed calculation of reg_wr_data)
    // initial
    // begin
    //     stall_flag_id_out = 1'b0;
    // end



    Mux2_1_5 reg_wr_mux(inst_read_reg_addr2, rd, stall_flag_id_in, reg_dst, reg_wr_addr); 
    
    // always @(posedge clk)
        // $display("ID", reg_wr_addr);
    // Mux2_1_32 wrb_mux(alu_data_out, mem_data_out, mem_to_reg, reg_wr_data);
    //#1
    // register file
    // RegisterFile registerFile(stall_flag_id_in, inst_read_reg_addr1, inst_read_reg_addr2, reg_wr_addr_wb, reg_wr_data, reg_write, clk, reg_file_rd_data1, reg_file_rd_data2, reset); // Replaced reg_wr_addr with reg_wr_addr_wb

    // sign extension
    SignExtend signExtend(stall_flag_id_in, inst_imm_field, sgn_ext_imm);

    always @(posedge clk)
        begin
            stall_flag_id_out = stall_flag_id_in;
           
            if (RegisterFileGlb.registers_flag[inst_read_reg_addr1]==1 || RegisterFileGlb.registers_flag[inst_read_reg_addr2]==1)
                    stall_flag_id_out <= 1'b1;
            else
                stall_flag_id_out <= 1'b0;
            $display("id flag", stall_flag_id_in);
                

            if (stall_flag_id_out)
                PC.pc = PC.pc - 4;
            $display("TESTINGGGGGGGGGGGGGGGG");
            // $display(stall_flag_if_out, " ", stall_flag_id_out, " ", stall_flag_ex_out);
        end


    always @(inst_read_reg_addr1, inst_read_reg_addr2, posedge clk, stall_flag_id_in)
	begin
	if (stall_flag_id_in==0)
	
		begin
			reg_file_rd_data1 <= RegisterFileGlb.registers[inst_read_reg_addr1];
			reg_file_rd_data2 <= RegisterFileGlb.registers[inst_read_reg_addr2];
		end
	end
    // left shift
    //#1
    assign imm_sgn_ext_lft_shft = sgn_ext_imm << 2; //redundant

    // always @(reg_file_rd_data1) begin
    //     jr_offset <= reg_file_rd_data1;
    // end

    // assign imm_field_wo_sgn_ext = inst_imm_field; //Added below block in place

    always @(inst_imm_field or stall_flag_id_in) 
    begin
    stall_flag_id_out = stall_flag_id_in;
    $display("id flag", stall_flag_id_out);
    if (stall_flag_id_out==0)
            
            begin
                imm_field_wo_sgn_ext <= inst_imm_field;
            end
        end
    // always @(posedge clk)
    // begin
    //     rd_out_id <= reg_wr_addr;
    // end
    // always @(negedge clk)
    // $display ("dsvrgssa");
    
    
    // reg [4:0] a;
    // initial
    // begin
        
    //     // rd_out_id <= reg_wr_addr;
        
    //     a <= reg_wr_addr; //haven't checked wire to reg conversion

    //     registers_flag[a] <= 1'b1;   //stall flag set 
    //     #1
        
        
    //     $display ("dsva",registers_flag[a]);
    //     $finish;
    //     // if (reg_write==1)
    //     //     Registers_flag.registers_flag[rd] <= 1'b1;
    // end
    reg [4:0] flag_reg_wr_addr;
    reg [4:0] flag_reg_wr_addr_wb;
    always @(negedge clk or reg_wr_addr)
    // #10
    
    #1
    begin
        stall_flag_id_out = stall_flag_id_in;
        
        flag_reg_wr_addr <= reg_wr_addr;
        flag_reg_wr_addr_wb <= reg_wr_addr_wb;
        rd_out_id <= reg_wr_addr;
        // stall_flag_if_out <= stall_flag_if;
        // stall_flag_ex_out <= stall_flag_ex;
        // stall_flag_id_out <= stall_flag,
        #1
        // $display("check address= %d",rd_out_id);
        if (reg_write_cu==1)
        begin
            RegisterFileGlb.registers_flag[reg_wr_addr] <= 1'b1;   //stall flag set
        end
        // if (reg_write==1)
        // begin
        //     RegisterFileGlb.registers_flag[reg_wr_addr_wb] <= 1'b0;
        //     // stall_flag_if_out <= 1'b0;
        //     stall_flag_id_out <= 1'b0;
        //     // stall_flag_ex_out <= 1'b0;
        // end
        $display("id flag", stall_flag_id_out);
    end

endmodule