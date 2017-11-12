`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [3:0] ALUControl;          // control bits for ALU operation
	reg [31:0] A, B;	          // inputs

	wire [31:0] ALUResult;	        // answer
	wire Zero;	                    // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

	initial begin
	
    /* Please fill in the implementation here... */
//Use delay of 200 (#200) between the first operation and    
//second operation when simulating using post-sysnthesis 
//functional simulation.
//after that, at least 50 between each change.

	//case 0
	#190 ALUControl <= 4'b0000; A <= 32'h64; B <= 32'h56;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 1
	#190 ALUControl <= 4'b0001;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);
/*
	//case 2
	#90 ALUControl <= 4'b0010;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 3
	#90 ALUControl <= 4'b0011;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 4
	#90 ALUControl <= 4'b0100;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 5
	#90 ALUControl <= 4'b0101;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 6
	#90 ALUControl <= 4'b0110;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 7
	#90 ALUControl <= 4'b0111;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 8
	#90 ALUControl <= 4'b0000; A <= 32'hFFFF0000; B <= 32'hF;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 9
	#90 ALUControl <= 4'b0001;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 10
	#90 ALUControl <= 4'b0010;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 11
	#90 ALUControl <= 4'b0011;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 12
	#90 ALUControl <= 4'b0100;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 13
	#90 ALUControl <= 4'b0000; A <= 32'hFFFFFFFF; B <= 32'h00000001;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 14
	#90 ALUControl <= 4'b0001;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 15
	#90 ALUControl <= 4'b0000; B <= 32'hFFFFFFFF;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 16
	#90 ALUControl <= 4'b0001;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 17
	#90 ALUControl <= 4'b0010;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 18
	#90 ALUControl <= 4'b0100;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 19
	#90 ALUControl <= 4'b0110;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 20
	#90 ALUControl <= 4'b0111;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 21
	#90 ALUControl <= 4'b1000; A<= 32'h00000FED; B <= 32'h00000005;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 22
	#90 ALUControl <= 4'b1001;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);

	//case 23
	#90 ALUControl <= 4'b1010;
	//#10 $display("ALUControl = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUControl, A, B, ALUResult, Zero);
*/	
	#90 ALUControl <= 4'b1011; A<= 32'b11111111111111111111111111110001;
	#90 ALUControl <= 4'b1011; A<= 32'b11111111111111111111111111111111;
	#90 ALUControl <= 4'b1011; A<= 32'b11000000000000000000000000000011;
	#90 ALUControl <= 4'b1011; A<= 32'b00000000000000000000000000000011;
	
	#90 ALUControl <= 4'b1100; A<= 32'b00000000000000000000000000000011;
	#90 ALUControl <= 4'b1100; A<= 32'b00001000000000000000000000000011;
	#90 ALUControl <= 4'b1100; A<= 32'b11000000000000000000000000000011;	
	#90 ALUControl <= 4'b1100; A<= 32'b0;	

	end

endmodule

