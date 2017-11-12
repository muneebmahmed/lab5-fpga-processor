`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - InstructionMemory_tb.v
// Description - Test the 'InstructionMemory_tb.v' module.
////////////////////////////////////////////////////////////////////////////////

module InstructionMemory_tb(); 

    wire [31:0] Instruction;

    reg [31:0] Address;

	InstructionMemory u0(
		.Address(Address),
        .Instruction(Instruction)
	);

    initial begin
	
    Address <= 0;
    #100;
	Address <= 4;
    #100;
    Address <= 8;
    #100;
    Address <= 12;
    #100;
    Address <= 16;
    #100;
    Address <= 20;
    #100;
    Address <= 24;
    #100;
  /*  Address <= 28;
    #100;
    Address <= 32;
    #100;
    Address <= 36;
    #100;
    Address <= 40;
    #100;    
    Address <= 44;
    #100;
    Address <= 48;
    #100;
    Address <= 52;
    #100;
    Address <= 56;
    #100;
    Address <= 60;
    #100;*/
    end

endmodule

