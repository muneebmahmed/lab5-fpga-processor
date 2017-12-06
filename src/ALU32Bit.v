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
	
	reg [31:0] X;
	reg [31:0] Result;
	reg [4:0] I;

	reg [5:0] lookup [0:31];

	initial begin
		lookup[0] <= 0;
		lookup[1] <= 31;
		lookup[2] <= 9;
		lookup[3] <= 30;
		lookup[4] <= 3;
		lookup[5] <= 8;
		lookup[6] <= 13;
		lookup[7] <= 29;
		lookup[8] <= 2;
		lookup[9] <= 5;
		lookup[10] <= 7;
		lookup[11] <= 21;
		lookup[12] <= 12;
		lookup[13] <= 24;
		lookup[14] <= 28;
		lookup[15] <= 19;
		lookup[16] <= 1;
		lookup[17] <= 10;
		lookup[18] <= 4;
		lookup[19] <= 14;
		lookup[20] <= 6;
		lookup[21] <= 22;
		lookup[22] <= 25;
		lookup[23] <= 20;
		lookup[24] <= 11;
		lookup[25] <= 15;
		lookup[26] <= 23;
		lookup[27] <= 26;
		lookup[28] <= 16;
		lookup[29] <= 27;
		lookup[30] <= 17;
		lookup[31] <= 18;
	end


	always @(ALUControl, A, B) begin
		case (ALUControl)
			0: begin
				ALUResult <= A + B;
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
			    X = X | (X >> 1);
			    X = X | (X >> 2);
			    X = X | (X >> 4);
			    X = X | (X >> 8);
			    X = X | (X >> 16);
			    X = X + 1;
			    X = X * 32'h076BE629;
			    if ( A == 32'hFFFFFFFF) begin
			        ALUResult = 32;
			    end
			    else begin
			        ALUResult = lookup[X[31:27]];
			    end

			    /*
			    X = ~A;
			    Result = 0;
			    for (I = 16; |I; I = I >> 1) begin
			        if (|(X >> I))
			            X = X >> I;
			        else
			            Result = Result + I;
			    end
			    ALUResult = Result;
			    if (A == 32'hFFFFFFFF)
			        ALUResult = 32;
			    */
			    /*
			    while (A[I]) begin
			         Result = Result + 1;
			         I = I + 1;
			    end*/
			    
			end
			12: begin
			    X = A;
			    X = X | (X >> 1);
			    X = X | (X >> 2);
			    X = X | (X >> 4);
			    X = X | (X >> 8);
			    X = X | (X >> 16);
			    X = X + 1;
			    X = X * 32'h076BE629;
			    if ( A == 0) begin
			        ALUResult = 32;
			    end
			    else begin
			        ALUResult = lookup[X[31:27]];
			    end
			    /*
			    Result = 0;
			    X = A;
			    for (I = 16; |I; I = I >> 1) begin
			        if (|(X >> I))
			            X = X >> I;
			        else
			            Result = Result + I;
			    end
			    ALUResult = Result;
			    if (A == 0)
			        ALUResult = 32;
			    */
			    /*
			    I = 31;
			    while (~A[I] && I >= 0) begin
			        Result = Result + 1;
			        I = I - 1;
			    end*/
			end
			default: begin
				ALUResult <= 32'h0;
			end
		endcase
		//Zero = (ALUResult == 0)? 1 : 0;
		//I think we need continuous assignment since zero should be updated AFTER ALUResult, not at same time
	end
	assign Zero = (ALUResult == 0);

endmodule

