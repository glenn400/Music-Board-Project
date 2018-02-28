`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:01:16 10/09/2013 
// Design Name: 
// Module Name:    clock_test 
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
module clock_gen(
	input wire clkin,
	output wire AN0,
	output wire AN1,	
	output wire AN2,
	output wire AN3,
	input wire reset
    );

    reg [17:0] count;

	// FILL CODE HERE to implement an 18-bit counter
	always@(posedge clkin)begin
		if (count == 18'b111111111111111111)
			count <= 18'b0;
		else
			count <= count + 1'b1;
	end

	assign AN0 = count[17] | count[16];
	assign AN1 = count[16] | ~(count[17]);
	assign AN2 = ~(count[16] & ~(count[17]));
	assign AN3 = ~(count[16] & count[17]);

endmodule
