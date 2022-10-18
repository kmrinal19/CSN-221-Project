module ControlUnit (opcode,reg_dst,branch,mem_read,mem_to_reg,alu_op,mem_write,alu_src,reg_write, reset);
  
  input [5:0] opcode;
  input reset;
  output reg reg_dst,branch,mem_read,mem_to_reg,mem_write,alu_src,reg_write;
  output reg [1:0] alu_op;
  
  parameter LW = 2'b00;
  parameter SW = 2'b00;
  parameter ADDI = 2'b00;
  parameter BEQ = 2'b01;
  parameter RType = 2'b10;
  parameter ADD = 6'b000000;
  parameter SUB = 6'b000001;
  parameter MUL = 6'b000010;


  always @(posedge reset)
  begin
   reg_dst <= 1'b0;
   branch <= 1'b0;
   mem_read <= 1'b0;
   mem_to_reg <= 1'b0;
   alu_op <= 2'b00;
   mem_write <= 1'b0;
   alu_src <= 1'b0;
   reg_write <= 1'b0;
  end

  always@(opcode)
    begin
      case (opcode)

        RType:           

          begin
          reg_dst<=1 ;
          branch<=0 ;
          mem_read<=0 ;
          mem_to_reg<=0 ;
          mem_write<=0 ;
          alu_src<=0 ;
          reg_write<=1 ;
          alu_op<=2'b10;
          end  
        
        LW:           

          begin
          reg_dst<=0 ;
          branch<=0 ;
          mem_read<=1 ;
          mem_to_reg<=1 ;
          mem_write<=0 ;
          alu_src<=1 ;
          reg_write<=1 ;
          alu_op<=2'b00;
          end
         
        
        SW:           

          begin
          //reg_dst<=1'bx ;
          branch<=0 ;
          mem_read<=0 ;
          mem_to_reg<=0 ;    //may be used in hazard detection -- assertion indicates register has been written
          mem_write<=1 ;
          alu_src<=1 ;
          reg_write<=0 ;
          alu_op<=2'b00;
          end
          
        BEQ:           

          begin
          //reg_dst<=1'bx ;
          branch<= 1;
          mem_read<=0 ;
          mem_to_reg<=0 ;
          mem_write<=0 ;
          alu_src<=0 ;
          reg_write<=0 ;
          alu_op<=2'b01;
          end

	    ADDI:           

          begin
          reg_dst<=0 ;
          branch<=0 ;
          mem_read<=0 ;
          mem_to_reg<=0 ;
          mem_write<=0 ;
          alu_src<=1 ;
          reg_write<=1 ;
          alu_op<=2'b00;
          end

	endcase
    end
  
  
endmodule
