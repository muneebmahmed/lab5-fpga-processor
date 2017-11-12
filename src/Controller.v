`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Muneeb Ahmed
// 
// Module - Controller.v
// Description - Controller
//
// INPUTS:-
// Instruction
//
// OUTPUTS:-
// lots of things 
//
// FUNCTIONALITY:-

module Controller(Instruction, ALUOp, ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, ALUSrc2, ReadReg1, ReadReg2, WriteReg, SEInstruction, Shmt);
	input [31:0] Instruction;

	output reg ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, ALUSrc2;
	output reg [3:0] ALUOp;
	output reg [4:0] ReadReg1, ReadReg2, WriteReg;
	output reg [15:0] SEInstruction;
	output reg [31:0] Shmt;

	always @(Instruction) begin
		SEInstruction <= Instruction[15:0];
		Shmt <= {27'd0, Instruction[10:6]};
		MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 0;
        ALUSrc <= 0;
        ALUSrc2 <= 0;
        ALUOp <= 0;
        RegWrite <= 1;
        ReadReg1 <= Instruction[25:21];//not for slr, sll, rotrv
        WriteReg <= Instruction[15:11];
        ReadReg2 <= Instruction[20:16];//not for slr, sll, rotrv
		case (Instruction[31:26])

			6'd0: begin
				case (Instruction[5:0])
					6'b100000: begin
						ALUOp <= 0;
					end
					6'b100010: begin
						ALUOp <= 1;
					end
					6'b100100: begin
						ALUOp <= 3;
					end
					6'b100101: begin
						ALUOp <= 4;
					end
					6'b101010: begin
						ALUOp <= 5;
					end
					6'd0: begin
						ReadReg1 <= Instruction[20:16];
						ALUOp <= 8;
						ALUSrc2 <= 1;
					end
					6'd2: begin
						ReadReg1 <= Instruction[20:16];
						ALUOp <= 9;
						ALUSrc2 <= 1;
					end
					6'd6: begin
						ReadReg1 <= Instruction[20:16];
						ReadReg2 <= Instruction[25:21];
						ALUOp <= 10;
					end
					default: begin
						ALUOp <= 0;
					end
				endcase

			end
			6'd28: begin
				case (Instruction[5:0])
					6'b100001: begin
						ALUOp <= 11;
					end
					6'b100000: begin
						ALUOp <= 12;
					end
					6'b00010: begin
						ALUOp <= 2;
					end
					default: begin
						ALUOp <= 11;
					end
				endcase
			end
			6'd8: begin
				WriteReg <= Instruction[20:16];
				ALUSrc <= 1;
				ALUOp <= 0;
				ALUSrc2 <= 0;
			end
			6'd13: begin
				WriteReg <= Instruction[20:16];
				ALUSrc <= 1;
				ALUOp <= 4;
			end
			6'd35: begin
				WriteReg <= Instruction[20:16];
				ALUOp <= 0;
				ALUSrc <= 1;
				MemRead <= 1;
				MemtoReg <= 1;
			end
			6'd43: begin
				RegWrite <= 0;
				ALUOp <= 0;
				MemWrite <= 1;
				MemtoReg <= 1;
				ALUSrc <= 1;
			end
			6'd5: begin
				RegWrite <= 0;
				PCSrc <= 1;
				ALUOp <= 6;
			end
			default: begin
				ALUOp <= 0;
			end
		endcase
	end

//module Datapath(Clk, Reset, ALUOp, ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, ReadReg1, ReadReg2, WriteReg, SEInstruction, Shmt, ALUSrc2, Instruction, WriteData);

endmodule
