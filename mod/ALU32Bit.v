`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports a set of arithmetic and 
// logical operaitons. The 'ALUResult' will output the corresponding 
// result of the operation based on the 32-Bit inputs, 'A', and 'B'. 
// The 'Zero' flag is high when 'ALUResult' is '0'. 
// The 'ALUControl' signal determines the function of the ALU based 
// on the table below. 

// Op|'ALUControl' value  | Description | Notes
// ==========================
// ADDITION       | 0000 | ALUResult = A + B
// SUBRACTION     | 0001 | ALUResult = A - B
// MULTIPLICATION | 0010 | ALUResult = A * B        (see notes below)
// AND            | 0011 | ALUResult = A and B
// OR             | 0100 | ALUResult = A or B
// SET LESS THAN  | 0101 | ALUResult =(A < B)? 1:0  (see notes below)
// SET EQUAL      | 0110 | ALUResult =(A=B)  ? 1:0
// SET NOT EQUAL  | 0111 | ALUResult =(A!=B) ? 1:0
// LEFT SHIFT     | 1000 | ALUResult = A << B       (see notes below)
// RIGHT SHIFT    | 1001 | ALUResult = A >> B	    (see notes below)
// ROTATE RIGHT   | 1010 | ALUResult = A ROTR B     (see notes below)

//--// Below instructions will be in in Part 2 //--// 
// COUNT ONES     | 1011 | ALUResult = A CLO        (see notes below)
// COUNT ZEROS    | 1100 | ALUResult = A CLZ        (see notes below)
//
// NOTES:-
// MULTIPLICATION : 32-bit signed multiplication results with 64-bit output.
//                  ALUResult will be set to lower 32 bits of the product value. 
//
// SET LESS THAN : ALUResult is '32'h000000001' if A < B.
// 
// LEFT SHIFT: The contents of the 32-bit "A" input are shifted left, 
//             inserting zeros into the emptied bits by the amount 
//             specified in B.
// RIGHT SHIFT: The contents of the 32-bit "A" input are shifted right, 
//             inserting zeros into the emptied bits by the amount 
//             specified in B.
//
// ROTR: logical right-rotate of a word by a fixed number of bits. 
//       The contents of the 32-bit "A" input are rotated right. 
//       The bit-rotate amount is specified by "B".
//	     ((A >> B) | (A << (32-B)))
//
//--// Below instructions will be in in Part 2 //--// 
// CLO: Count the number of leading ones in a word.
//      Bits 31..0 of the input "A" are scanned from most significant to 
//      least significant bit.  
// 
// CLZ: Count the number of leading zeros in a word.
//      Bits 31..0 of the input "A" are scanned from most significant to 
//      least significant bit.  
//
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [3:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs

	output reg [31:0] ALUResult;	// answer
	output Zero;	    // Zero=1 if ALUResult == 0
	wire [31:0] Sum;
	reg [31:0] X;
	integer Result;
	reg [4:0] I;
	//CLA add(A,B,Sum);


	always @(ALUControl, A, B) begin
		case (ALUControl)
			0: begin
				ALUResult <= A+B+32'd0;
			end
			1: begin
				ALUResult <= A - B;
			end
			2: begin
				ALUResult <= (A * B);//[31:0];
			end
			3: begin
				ALUResult <= A & B;
			end
			4: begin
				ALUResult <= A | B;
			end
			5: begin
				ALUResult <= (A < B)? 32'h1 : 32'h0; //ALUResult <= (A<B); also works, is more compact
			end
			6: begin
				ALUResult <= (A == B);
			end
			7: begin
				ALUResult <= (A != B);
			end
			8: begin
				ALUResult <= (A << B);
			end
			9: begin
				ALUResult <= (A >> B);
			end
			10: begin
				ALUResult <= ((A >> B) | (A << (32-B)));
			end
			11: begin
			    X = ~A;
			    Result = 0;
			    for (I = 16; |I; I = I >> 1) begin
			        if (|(X >> I))
			            X = X >> I;
			        else
			            Result = Result + I;
			    end
			    
			    if (A == 32'hFFFFFFFF)
			        ALUResult = 32;
			        else
			        ALUResult = Result;
			    /*
			    while (A[I]) begin
			         Result = Result + 1;
			         I = I + 1;
			    end*/
			    
			end
			12: begin
			    Result = 0;
			    X = A;
			    for (I = 16; |I; I = I >> 1) begin
			        if (|(X >> I))
			            X = X >> I;
			        else
			            Result = Result + I;
			    end
			   
			    if (A == 0)
			        ALUResult = 32;
			        else
			         ALUResult = Result;
			    /*
			    I = 31;
			    while (~A[I] && I >= 0) begin
			        Result = Result + 1;
			        I = I - 1;
			    end*/
			end
			default: begin
				ALUResult <= 32'd0;
			end
		endcase
		//Zero = (ALUResult == 0)? 1 : 0;
		//I think we need continuous assignment since zero should be updated AFTER ALUResult, not at same time
	end
	assign Zero = (ALUResult == 0);

endmodule

