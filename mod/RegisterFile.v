`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu

// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//                          (a 32x32 regsiter file with two read ports and one write port)
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2, debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19);

	input RegWrite, Clk;
	input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input [31:0] WriteData;

	output [31:0] ReadData1, ReadData2;
	
	//for post-synthesis
	output [31:0] debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19;
	//output wire [31:0] out_data;
	//output wire [31:0] debug_reg;

	//creates 32 32-bit registers
	(* mark_debug = "true" *) reg [31:0] regFile [0:31];

	initial begin
		regFile[0] <= 32'd0;
	end

	always @(posedge Clk) begin
		if (RegWrite) begin
			regFile[WriteRegister] <= WriteData;
		end
	end

	//always @(ReadRegister1,ReadRegister2, regFile) begin
	
		assign ReadData1 = regFile[ReadRegister1];
		assign ReadData2 = regFile[ReadRegister2];
	
	//end


	//below is for post-synthesis simulation
	assign debug_Reg8 = regFile[8];
	assign debug_Reg16 = regFile[16];
	assign debug_Reg17 = regFile[17];
	assign debug_Reg18 = regFile[18];
	assign debug_Reg19 = regFile[19];
	//assign out_data = regFile[23];
	//assign debug_reg = regFile[10];

endmodule
