`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Muneeb Ahmed
// 
// Module - TopProcessor.v
// Description - Top Module
//
// INPUTS:-
// Clk, Reset
//
// OUTPUTS:-
// WriteData 
//
// FUNCTIONALITY:-

module TopProcessor(Clk, Reset, WriteData);
//module TopProcessor(Clk, Reset, Hold_Clk, out7, en_out);

	input Clk, Reset;	//Hold_Clk;
	output [31:0] WriteData;

	wire [3:0] ALUOp;
	wire ALUSrc, ALUSrc2, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc;
	wire [4:0] ReadReg1, ReadReg2, WriteReg;
	wire [15:0] SEInstruction;
	wire [31:0] Instruction, Shmt;

	//wire Clk_out;
	//output [6:0] out7;
	//output [7:0] en_out;
	//wire [31:0] WriteData;

	(* mark_debug = "true" *) wire [31:0] debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19;

	Controller controller(Instruction, ALUOp, ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, ALUSrc2, ReadReg1, ReadReg2, WriteReg, SEInstruction, Shmt);

	Datapath datapath(Clk, Reset, ALUOp, ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, ReadReg1, ReadReg2, WriteReg, SEInstruction, Shmt, ALUSrc2, Instruction, WriteData, debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19);

	//ClkDiv(Clk, Hold_Clk, Clk_out);
	//Datapath datapath(Clk_out, Reset, ALUOp, ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, ReadReg1, ReadReg2, WriteReg, SEInstruction, Shmt, ALUSrc2, Instruction, WriteData, debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19);
	//TwoDigitDisplay(Clk, debug_Reg16[6:0], out7, en_out);

	//module Datapath(Clk, Reset, ALUOp, ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, ReadReg1, ReadReg2, WriteReg, SEInstruction, Shmt, ALUSrc2, Instruction, WriteData);

	//module Controller(Instruction, ALUOp, ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, ALUSrc2, ReadReg1, ReadReg2, WriteReg, SEInstruction, Shmt);

endmodule
