`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - PCAdder_tb.v
// Description - Test the 'PCAdder.v' module.
////////////////////////////////////////////////////////////////////////////////

module PCAdder_tb();

    reg [31:0] PCResult;

    wire [31:0] PCAddResult;

    PCAdder u0(
        .PCResult(PCResult), 
        .PCAddResult(PCAddResult)
    );

	initial begin
	
	#100 PCResult <= 32'h00000000;
	//#20 ;//$display("PCResult = %h, PCAddResult = %h", PCResult, PCAddResult);

	//case 2
	#100 PCResult <= 32'h00000100;
	//#20 $display("PCResult = %h, PCAddResult = %h", PCResult, PCAddResult);

	//case 3
	#100 PCResult <= 32'hFFFFFFFC;
	//#20 $display("PCResult = %h, PCAddResult = %h", PCResult, PCAddResult);

	//case 4
	#100 PCResult <= 32'hFD03475A;
	//s#20 $display("PCResult = %h, PCAddResult = %h", PCResult, PCAddResult);

	end

endmodule

