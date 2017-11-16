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

	input Clk, Reset;
	output [31:0] WriteData;

	wire [3:0] ALUOp;
	wire ALUSrc, ALUSrc2, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc;
	wire [4:0] ReadReg1, ReadReg2, WriteReg;
	wire [15:0] SEInstruction;
	wire [31:0] Instruction, Shmt;

	(* mark_debug = "true" *) wire [31:0] debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19;

	Controller controller(Instruction, ALUOp, ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, ALUSrc2, ReadReg1, ReadReg2, WriteReg, SEInstruction, Shmt);

	Datapath datapath(Clk, Reset, ALUOp, ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, ReadReg1, ReadReg2, WriteReg, SEInstruction, Shmt, ALUSrc2, Instruction, WriteData, debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19);

	//module Datapath(Clk, Reset, ALUOp, ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, ReadReg1, ReadReg2, WriteReg, SEInstruction, Shmt, ALUSrc2, Instruction, WriteData);

	//module Controller(Instruction, ALUOp, ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, ALUSrc2, ReadReg1, ReadReg2, WriteReg, SEInstruction, Shmt);

endmodule
