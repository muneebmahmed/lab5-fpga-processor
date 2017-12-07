`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: R. Thamvichai
// 
// Create Date: 09/01/2015 01:15:14 PM
// Design Name: 
// Module Name: TwoDigitDisplay
//////////////////////////////////////////////////////////////////////////////////
module TwoDigitDisplay(Clk, Number, out7, en_out);
    input  Clk;
    input  [31:0] Number;
    output [6:0] out7; //seg a, b, ... g
    output reg [7:0] en_out;
             
    reg  [3:0] in4;        
    reg  [3:0] firstdigit;
    reg  [3:0] seconddigit;
    reg  [3:0] thirddigit, fourthdigit, fifthdigit, sixthdigit, seventhdigit, eighthdigit;
    
    //--------- --------- --------- --------- //
    //-- to use the module SevenSegment 
         SevenSegment m1(in4, out7);
    //--------- --------- --------- --------- //
         
    //-- divider counter for ~95.3Hz refresh rate (with 100MHz main clock)
    integer  cnt = 0;
    
    //-- to seperate each decimal digit for display
    always @(Number) begin
            if (Number < 100000000)
                begin
                    firstdigit <= Number%10;
                    seconddigit <= (Number/10)%10;
                    thirddigit <= (Number/100)%10;
                    fourthdigit <= (Number/1000)%10;
                    fifthdigit <= (Number/10000)%10;
                    sixthdigit <= (Number/100000)%10;
                    seventhdigit <= (Number/1000000)%10;
                    eighthdigit <= (Number/10000000);
                end
//            if (Number < 100)
//                begin
//                    firstdigit <= Number%10;
//                    seconddigit <= Number/10;
//                end 
             else
             begin
                    firstdigit <= 4'b1111;
                    seconddigit <= 4'b1111;
                    thirddigit <= 4'b1111;
                    fourthdigit <= 4'b1111;
                    fifthdigit <= 4'b1111;
                    sixthdigit <= 4'b1111;
                    seventhdigit <=4'b1111;
                    eighthdigit <= 4'b1111;
             end
    end
    
    //-- to display the number in the appropriate 7-segment digit
    always @(posedge Clk) begin
    cnt= cnt + 1;
        case(cnt[20:16])  //100MHz/(2^20) = 95.3 Hz
            5'b00001: begin en_out <= 8'b11111110; in4 = firstdigit; end
            5'b00011: begin en_out <= 8'b11111101; in4 = seconddigit; end
            //can be used if need to display more than 2 digits
            5'b00101: begin en_out <= 8'b11111011; in4 = thirddigit; end
            5'b00111: begin en_out <= 8'b11110111; in4 = fourthdigit; end
            5'b01001: begin en_out <= 8'b11101111; in4 = fifthdigit; end
            5'b01011: begin en_out <= 8'b11011111; in4 = sixthdigit; end
            5'b01101: begin en_out <= 8'b10111111; in4 = seventhdigit; end
            5'b01111: begin en_out <= 8'b01111111; in4 = eighthdigit; end
            5'b10000: begin cnt = 0; end
            default: begin en_out <= 8'b11111111; in4 = 4'b1111; end 
        endcase
     end
     
     
    
endmodule
