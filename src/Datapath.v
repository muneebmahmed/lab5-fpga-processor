`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Muneeb Ahmed
// 
// Module - Datapath.v
// Description - Datapath
//
// INPUTS:-
// lots of things
//
// OUTPUTS:-
// WriteData
// Instruction 
//
// FUNCTIONALITY:-

module Datapath(Clk, Reset, ALUOp, ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, ReadReg1, ReadReg2, WriteReg, SEInstruction, Shmt, ALUSrc2, Instruction, WriteData, debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19);

	input Clk, Reset, ALUSrc, MemWrite, MemRead, MemtoReg, RegWrite, PCSrc, ALUSrc2;
	input [3:0] ALUOp;
	input [4:0] ReadReg1, ReadReg2, WriteReg;
	input [15:0] SEInstruction;
	input [31:0] Shmt;
	output [31:0] Instruction, WriteData;

	wire [31:0] ReadData1, ReadData2, ALUResult, ReadDataDM, PCount, PCnt4;
	wire [31:0] ALUMux1, ALUMux2, PCMux, DMMux, SE, SESL2, SESL2Add;
	wire ALUZero, PCALUZero, PCALUZero2, PCSrcandALUZ;

	(* mark_debug = "true" *) output [31:0] debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19;

	ALU32Bit alu(ALUOp, ReadData1, ALUMux2, ALUResult, ALUZero);

	//RegisterFile regFile(ReadReg1, ReadReg2, WriteReg, DMMux, RegWrite, Clk, ReadData1, ReadData2);
	RegisterFile regFile(ReadReg1, ReadReg2, WriteReg, DMMux, RegWrite, Clk, ReadData1, ReadData2, debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19);

	DataMemory DM(ALUResult, ReadData2, Clk, MemWrite, MemRead, ReadDataDM);
	Mux32Bit2To1 dmux(DMMux, ReadDataDM, ALUResult, MemtoReg);
	ProgramCounter pc(PCMux, PCount, Reset, Clk);
	PCAdder pcadd(PCount, PCnt4);
	InstructionMemory im(PCount, Instruction);
	SignExtension se(SEInstruction, SE);
	Mux32Bit2To1 muxalu(ALUMux1, SE, ReadData2, ALUSrc);
	Mux32Bit2To1 muxalu2(ALUMux2, Shmt, ALUMux1, ALUSrc2); //Shmt is at 1
	//ALU32Bit sl2(8, SE, 2, SESL2, PCALUZero);
	assign SESL2 = { SE[29:0] , 2'b00 };
	//ALU32Bit sl2add(0, PCnt4, SESL2, SESL2Add, PCALUZero2);
	assign SESL2Add = PCnt4 + SESL2;
	assign PCSrcandALUZ = PCSrc & ALUZero;
	Mux32Bit2To1 pcmux(PCMux, SESL2Add, PCnt4, PCSrcandALUZ); //Can I do this
	//module ALU32Bit(ALUControl, A, B, ALUResult, Zero);
	//module DataMemory(Address, WriteData,Clk,MemWrite,MemRead, ReadData); 
	//module InstructionMemory(Address, Instruction); 
	//module Mux32Bit2To1(out, inA, inB, sel);
	//module PCAdder(PCResult, PCAddResult);
	//module ProgramCounter(Address, PCResult, Reset, Clk);
	//module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);
	//module SignExtension(in, out);

	assign WriteData = DMMux; //can just rid of DMMux and use WriteData?

endmodule
