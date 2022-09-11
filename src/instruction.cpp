#include<bitset>
#include <string>
#include <vector>

#include "utils.h"
#include "instruction.h"

Instruction::Instruction(unsigned short instruction_opcode):instruction_opcode(instruction_opcode){}

unsigned short Instruction::get_instruction_opcode() {
	return this->instruction_opcode;
}

Instruction * Instruction::find_class_and_parse(std::string raw_instruction){
	trim(raw_instruction);
	std::string opcode = "";
	for(auto c=raw_instruction.begin(); c!= raw_instruction.end(); ++c ) {
		if(*c==' '){
			int pos = c - raw_instruction.begin();
			int len = raw_instruction.length() - pos;
			raw_instruction = raw_instruction.substr(pos, len);
			break;
		}
		opcode += *c;
	}
	std::vector<std::string> split_instruction = split(raw_instruction, ',');
	// TODO: Handle error if opcode is invalid
	unsigned short opcode_type = OPCODE_MAP[opcode];
	if(opcode_type==R_TYPE){
		Instruction * r_instruction = new RInstruction(opcode_type, split_instruction, FUNCTION_MAP[opcode]);
		return r_instruction;
	}
	else if(opcode_type==J) {
		Instruction * j_instruction = new UJInstruction(opcode_type, split_instruction);
		return j_instruction;
	}
	else {
		Instruction * i_instruction = new IInstruction(opcode_type, split_instruction);
		return i_instruction;
	}
}
RInstruction::RInstruction(short opcode_type, std::vector<std::string> operands, unsigned short function):Instruction(opcode_type){
	// TODO: Handle errors for operands
	if(operands.size() == 3){
		rs = parse_register_string(operands[0]);
		rt = parse_register_string(operands[1]);
		rd = parse_register_string(operands[2]);
		function = function;
	}
}

unsigned int RInstruction::parse() {
	std::bitset<32> instruction(0);
	std::bitset<3> opcode_bits(get_instruction_opcode());
	std::bitset<3> buffer(0);
	std::bitset<5> rs_bits(this->rs);
	std::bitset<5> rt_bits(this->rt);
	std::bitset<5> rd_bits(this->rd);
	std::bitset<3> function_bits(this->function);
	instruction = ((((opcode_bits.to_ulong()<<3 | buffer.to_ulong())<<5 | rs_bits.to_ulong())<<5 | rt_bits.to_ulong())<<5 | rd_bits.to_ulong())<<3 | function_bits.to_ulong()<<8;
	return (unsigned int)instruction.to_ulong();
}

IInstruction::IInstruction(short opcode_type, std::vector<std::string> operands):Instruction(opcode_type){
	// TODO: Handle errors for instruction params
    if(operands.size() == 3 )
	{
		rs = parse_register_string(operands[0]);
		rt = parse_register_string(operands[1]); 
		address = (unsigned short)stoi(operands[2]);
	}
}

unsigned int IInstruction::parse()
{
	// TODO: Handle errors for instruction params
	std::bitset<32> instruction(0);
	std::bitset<3> opcode_bits(get_instruction_opcode());
	std::bitset<3> buffer(0);
	std::bitset<5> rs_bits(rs);
	std::bitset<5> rt_bits(rt);
	std::bitset<16> address_bits(address);
	instruction = (((opcode_bits.to_ulong()<<3 | buffer.to_ulong())<<5 | rs_bits.to_ulong())<<5 | rt_bits.to_ulong())<<5 | address_bits.to_ulong();
	return (unsigned int)instruction.to_ulong();
}

UJInstruction::UJInstruction(short opcode_type, std::vector<std::string> operands):Instruction(opcode_type){
	// TODO: Handle errors for instruction params
	short opcode = opcode_type;
	if (operands.size() == 1)
	{
		address = stoi(operands[0]);
	}		
}

unsigned int UJInstruction::parse()
{
	std::bitset<32> instruction(0);
	std::bitset<3> buffer(0);
	std::bitset<3> opcode(get_instruction_opcode());
	std::bitset<26> binary_address(address);
	instruction = ((opcode.to_ulong()<<3)| buffer.to_ulong())<<26 | binary_address.to_ulong();

	return (unsigned int)instruction.to_ulong();
}