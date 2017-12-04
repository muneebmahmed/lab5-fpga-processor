`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2017 02:06:51 PM
// Design Name: 
// Module Name: CLA32Bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CLA32Bit(A,B,S);
	input [31:0] A,B;
	wire C[3:0];
	output [32:0] S;

	//These are put together carry ripple fashion, not carry lookahead
	CLA8Bit one(A[7:0]^B[7:0],A[7:0]&B[7:0],1'b0,S[7:0],C[0]);
	CLA8Bit two(A[15:8]^B[15:8],A[15:8]&B[15:8],C[0],S[15:8],C[1]);
	CLA8Bit three(A[23:16]^B[23:16],A[23:16]&B[23:16],C[1],S[23:16],C[2]);
	CLA8Bit four(A[31:24]^B[31:24],A[31:24]&B[31:24],C[2],S[31:24],C[3]);

	assign S[32] = C[3];
endmodule
