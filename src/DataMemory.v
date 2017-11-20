`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - data_memory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K (x32) memory, for which we need 10 bits for the address.  
// In order to implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. 
// The 'WriteData' value is written into the location whose address 
// corresponds to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 
// 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is NOT clocked.
//
// you need to declare a 2d array. in this case we need 
// an array of 1024 (1K) 32-bit elements (1024 elements where each element is 32-bit wide).  
// for example, to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk;
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 

    output reg[31:0] ReadData; // Contents of memory location at Address

    /* Please fill in the implementation here */
    reg [31:0] memory [0:1023];
    
    initial begin
//        memory[0] <= 32'h0;
//        memory[1] <= 32'h0;
//        memory[2] <= 32'h0;

        //Task 3 Stuff Here
        
        memory[0] = 32'h30e;
        memory[1] = 32'h50;
        memory[2] = 32'h369;
        memory[3] = 32'h23e;
        memory[4] = 32'h1eb;
        memory[5] = 32'h84;
        memory[6] = 32'h31f;
        memory[7] = 32'h13e;
        memory[8] = 32'h31b;
        memory[9] = 32'h34d;
        memory[10] = 32'h61;
        memory[11] = 32'h3e3;
        memory[12] = 32'hbc;
        memory[13] = 32'h108;
        memory[14] = 32'h23b;
        memory[15] = 32'h2be;
        memory[16] = 32'hfd;
        memory[17] = 32'h371;
        memory[18] = 32'h3da;
        memory[19] = 32'he2;
        memory[20] = 32'h277;
        memory[21] = 32'h4a;
        memory[22] = 32'h17;
        memory[23] = 32'hc8;
        memory[24] = 32'h3ca;
        memory[25] = 32'h1f4;
        memory[26] = 32'hba;
        memory[27] = 32'h2a3;
        memory[28] = 32'ha5;
        memory[29] = 32'h375;
        memory[30] = 32'h228;
        memory[31] = 32'h39c;
        memory[32] = 32'h1d2;
        memory[33] = 32'h2b8;
        memory[34] = 32'h2e9;
        memory[35] = 32'h81;
        memory[36] = 32'h28e;
        memory[37] = 32'h1d1;
        memory[38] = 32'h2ed;
        memory[39] = 32'hf3;
        memory[40] = 32'h6f;
        memory[41] = 32'h34b;
        memory[42] = 32'he7;
        memory[43] = 32'h31b;
        memory[44] = 32'h112;
        memory[45] = 32'h1f6;
        memory[46] = 32'h2a;
        memory[47] = 32'h305;
        memory[48] = 32'h1c6;
        memory[49] = 32'h6d;
        memory[50] = 32'h392;
        memory[51] = 32'h229;
        memory[52] = 32'hab;
        memory[53] = 32'he3;
        memory[54] = 32'h31c;
        memory[55] = 32'hcf;
        memory[56] = 32'h206;
        memory[57] = 32'h11a;
        memory[58] = 32'hf6;
        memory[59] = 32'h24f;
        memory[60] = 32'h35c;
        memory[61] = 32'h37d;
        memory[62] = 32'h3e3;
        memory[63] = 32'h24;
        memory[64] = 32'h40;

    end
    
	always @(posedge Clk) begin
        if (MemWrite == 1'b1) begin
            memory[Address[11:2]] <= WriteData;
        end
    end    
    
    always @(*) begin
        if (MemRead == 1'b1) begin
                ReadData <= memory[Address[11:2]];
        end
        else
                ReadData <= 32'h0;    
    end    
endmodule
