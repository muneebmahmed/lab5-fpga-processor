`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #100 Clk <= ~Clk;
	end

	initial begin
	
     Address <= 32'd0;
	WriteData <=32'h12345678;
	MemWrite <= 1'b1;
	MemRead <= 1'b0;
	#75;
	Address <=32'd4;
	WriteData <= 32'habcdef98;
	#200;
	WriteData<=32'hffffffff;
	Address<=32'd8;
	#200;
	Address <= 32'd0;
	MemWrite <=1'b0;
	MemRead <=1'b1;	
	end

endmodule

