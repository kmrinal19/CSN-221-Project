module EX(stall_flag, clk, rs, rt, sign_ext, ALUSrc, ALUOp, branch, reset, pc, zero, address, resultOut, pcout, offset);
    input stall_flag;
    input reset;        //To start from a known state - not necessary
    input clk;
    input wire [31:0] pc;
    input wire branch;
    input wire [31:0] rs;
    input wire [31:0] rt;
    input wire [31:0] sign_ext;
    input wire ALUSrc;          //to choose bw rt and sign extend ,from cu
    input wire [1:0] ALUOp;     //from cu
    wire [5:0] funct;     //from decode unit
    reg [3:0] ALUControl;
    reg [31:0] result;
    output reg zero;
    output reg [31:0] address;
    output reg [31:0] resultOut;
    output reg [31:0] pcout;
    // output reg [3:0] ALUControlOut;

    // wire [3:0] ALUControl;
    // wire [31:0] result;
    output reg [31:0] offset;
    // wire [31:0] neg_data2 = -data2;
    reg [31:0] data2, t_pcout, t_offset, t_address;
    reg t_zero;
    // pcout = pc;

    always @(posedge clk)
    begin
        if (stall_flag==0)
            begin
            if(ALUSrc == 0)
            data2 <= rt;
            else
            data2 <= sign_ext;  //assumed that 16-bit has been extended to 32-bit by ID unit
            end
    end

    //AluControl

    parameter LW = 2'b00;
    parameter SW = 2'b00;
    parameter ADDI = 2'b00;
    parameter BEQ = 2'b01;
    parameter RType = 2'b10;
    parameter ADD = 6'b000000;
    parameter SUB = 6'b000001;
    parameter MUL = 6'b000010;

    assign funct = sign_ext[5:0];

    always @(posedge clk)
    begin
        if (stall_flag==0)
        begin
            t_pcout = pc;
        case(ALUOp) //aluop same for lw and sw and addi... first it is going to load before addi

            LW: //address always in rs and data in rt
            begin
                ALUControl = 4'b0000;
                t_offset = sign_ext; //check if shift is necessary
                data2 = t_offset;
            end

            SW:
            begin
                ALUControl = 4'b0000;
                t_offset = sign_ext; //check if shift is necessary
                data2 = t_offset;
            end
            ADDI:
                ALUControl = 4'b0000;

            BEQ:
                ALUControl = 4'b0001;

        RType:
            case(funct)

                ADD:
                    ALUControl = 4'b0000;

                SUB:
                    ALUControl = 4'b0001;

                MUL:
                    ALUControl = 4'b0010;

            endcase


        endcase

        end
    end

    always @(posedge reset) zero <= 1'b0;
    always @(posedge clk)
    begin
    if (stall_flag==0)
        begin
        if(rs == data2)
        t_zero <= 1'b1;
        else
        t_zero <= 1'b0;

        case(ALUControl)

        4'b0000:
            begin
            $display("time = %3d, data1=%d, data2=%d \n", $time, rs, data2);
            result <= rs + data2;
            end


        4'b0001:
            begin
            result <= rs - data2;
            end

        4'b0010:
            begin
            result <= rs * data2;
            end


        endcase

        if (branch==1 && t_zero==1)
            begin
                t_offset = sign_ext<<2;
            end
        end
    end

    always @(posedge clk)
    begin
    if (stall_flag==0)

    // #1
    begin
        if (branch==1 && t_zero==1)
        begin
            t_offset = sign_ext<<2;
            t_address = offset + pc;
            t_pcout = t_address;
        end
    end
    end

    always@(negedge clk)
    begin
    if (stall_flag==0)
        begin
        zero <= t_zero;
        address <= t_address;
        offset <= t_offset;
        pcout <= t_pcout;
        resultOut<=result;
        end
    end

    always@(posedge clk)
        $display("EX", resultOut);
endmodule