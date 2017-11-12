`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Muneeb Ahmed
// 
// Module - TopProcessor.v
// Description - Test the processor
//
////////////////////////////////////////////////////////////////////////////////

module TopProcessor_tb();

	reg Clk, Reset;
	wire [31:0] WriteData;

	TopProcessor top(Clk, Reset, WriteData);

	initial begin
		Clk <= 1'b0;
		forever #100 Clk <= ~Clk;
	end

	initial begin
		Reset <= 1;
		#200;
		Reset <= 0;
	end
endmodule
