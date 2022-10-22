// module hazard_detector (reset, reg_write, if_id_instruction, id_ex_rd, stall_flag_ex, stall_flag_if, stall_flag_ex);

// input reset;
// input reg_write;
// input [31:0] if_id_instruction;
// input [4:0] id_ex_rd;
// output reg stall_flag_ex, stall_flag_if, stall_flag_id;

// always @(reset)
// begin
//     stall_flag_ex <= 1;
//     stall_flag_id <= 1;
//     stall_flag_if <= 1;
// end

// always @(reg_write or if_id_instruction or id_ex_rd)
// begin 
//     if (if_id_instruction[25:21] == id_ex_rd || if_id_instruction[20])
// end