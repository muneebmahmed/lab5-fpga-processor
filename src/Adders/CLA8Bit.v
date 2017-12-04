`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2017 01:05:32 PM
// Design Name: 
// Module Name: CLA
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


module CLA8Bit(P,G,Ci,S,Co);
	input [7:0] P, G;
	//input [3:0] A,B;
	input Ci;
	reg [7:0] C;
	output reg Co;
	output reg [7:0] S;
	//output reg [31:0] C;
	always @(Ci,G,P) begin
		S[0] <= P[0]^Ci;
		//Normally we would do Gi+PiCi-1 but now it'll be Gi+PiCi because we set Ci = Ci+1
		C[0] <= G[0] | (P[0]&Ci);
		C[1] <= G[1] | (P[1]&G[0]) | (P[1]&P[0]&Ci);
		C[2] <= G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&Ci);
		C[3] <= G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&Ci);  
		C[4] <= G[4] | (P[4]&G[3]) | (P[4]&P[3]&G[2]) | (P[4]&P[3]&P[2]&G[1]) | (P[4]&P[3]&P[2]&P[1]&G[0]) | (P[4]&P[3]&P[2]&P[1]&P[0]&Ci); 
		C[5] <= G[5] | (P[5]&G[4]) | (P[5]&P[4]&G[3]) | (P[5]&P[4]&P[3]&G[2]) | (P[5]&P[4]&P[3]&P[2]&G[1]) | (P[5]&P[4]&P[3]&P[2]&P[1]&G[0]) | (P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&Ci); 
		C[6] <= G[6] | (P[6]&G[5]) | (P[6]&P[5]&G[4]) | (P[6]&P[5]&P[4]&G[3]) | (P[6]&P[5]&P[4]&P[3]&G[2]) | (P[6]&P[5]&P[4]&P[3]&P[2]&G[1]) | (P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&G[0]) | (P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&Ci); 
		C[7] <= G[7] | (P[7]&G[6]) | (P[7]&P[6]&G[5]) | (P[7]&P[6]&P[5]&G[4]) | (P[7]&P[6]&P[5]&P[4]&G[3]) | (P[7]&P[6]&P[5]&P[4]&P[3]&G[2]) | (P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&G[1]) | (P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&G[0]) | (P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&Ci);
		//These will Carry properly so need to get the S value which is Si = PixnorCi
	end
	always @(C,P) begin
		S[7:1] <= P[7:1]^C[6:0];
		Co <= C[7];
	end
	//always @(*) begin
	//C <= (A&B) | (C& (A | B));
	//end
endmodule
