`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:27:47 09/17/2013 
// Design Name: 
// Module Name:    bcd_to_sseg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module BCD_to_Sseg_4Digits(
    input wire [15:0] BCD,
	 input wire AN3,
	 input wire AN2,
	 input wire AN1,
	 input wire AN0,
      output reg [7:0] Sseg_from_BCD
    );
	 
	 reg [3:0] digit;
	 
	 always@(BCD,AN3,AN2,AN1,AN0) begin
		if ({AN3,AN2,AN1,AN0} == 4'B0111)
		   digit = ({BCD[15], BCD[14], BCD[13], BCD[12] });
		else if ({AN3,AN2,AN1,AN0} == 4'b1011)
		   digit = ({BCD[11], BCD[10], BCD[9], BCD[8] });
		else if ({AN3,AN2,AN1,AN0} == 4'b1101)
		   digit = ({BCD[7], BCD[6], BCD[5], BCD[4] });
		else if ({AN3,AN2,AN1,AN0} == 4'b1110)
		   digit = ({BCD[3], BCD[2], BCD[1], BCD[0] });
		else
			digit = 4'b1111;    // default case in case structure
	 end
	
	 always@(digit) begin
			case (digit)
				4'b0000 : Sseg_from_BCD = 8'b00000011;
				4'b0001 : Sseg_from_BCD = 8'b10011111;
				4'b0010 : Sseg_from_BCD = 8'b00100101;
				4'b0011 : Sseg_from_BCD = 8'b00001101;
				4'b0100 : Sseg_from_BCD = 8'b10011001;
				4'b0101 : Sseg_from_BCD = 8'b01001001;
				4'b0110 : Sseg_from_BCD = 8'b01000001;
				4'b0111 : Sseg_from_BCD = 8'b00011111;
				4'b1000 : Sseg_from_BCD = 8'b00000001;
				4'b1001 : Sseg_from_BCD = 8'b00001001;
				4'b1010 : Sseg_from_BCD = 8'b00010001;
				4'b1011 : Sseg_from_BCD = 8'b11000001;
				4'b1100 : Sseg_from_BCD = 8'b01100011;
				4'b1101 : Sseg_from_BCD = 8'b10000101;
				4'b1110 : Sseg_from_BCD = 8'b01100001;
				4'b1111 : Sseg_from_BCD = 8'b01110001;
				default : Sseg_from_BCD = 8'b00000001;
			endcase
	 end
	
	 
endmodule
