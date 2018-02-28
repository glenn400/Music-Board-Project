`timescale 1ns / 1ps

  module music_notes(
	input wire clk,
	//input wire cv,						// count variable accesses which part of 100 MHz signal will be used 
	input wire reset,
	input wire [3:0] v,						// value for i to use correct value
	input wire out,
	output wire speaker
);
// count variable will be either 
// 15 , 16 , 17 , 18
// counter will range between values
// 95,556.617 - 382,219.164
// where 382,219.164 coincides to C4 at 261.63


// from http://verilogams.com/refman/basics/variables.html
// make array of integers
// integers relate counter , how many times it should count to
// output the desired sound then reset


reg [18:0] count;

// 0000 0000 0000 0000 000

always@(posedge clk) begin // ***
		if (out == 1'b1) begin // **
			if ( v == 4'b0001) begin //*
				if ( count == 382219 ) 
					count <= 19'b0000000000000000000;
				else
					count <= count + 1'b1;
				end // **
			else if ( v == 4'b0010) begin
				if ( count == 340530 ) 
					count <= 19'b0000000000000000000;
				else
					count <= count + 1'b1;
				end // **
			else if ( v == 4'b0011) begin
				if ( count == 303370 ) 
					count <= 19'b0000000000000000000;
					
				else
					count <= count + 1'b1;
				end // **
			else if ( v == 4'b0100) begin
				if ( count == 286344 ) 
					count <= 19'b0000000000000000000;
					
				else
					count <= count + 1'b1;
				end // **
			else if ( v == 4'b0101) begin
				if ( count == 255102 ) 
					count <= 19'b0000000000000000000;
					
					count <= count + 1'b1;
				end // **
			else if ( v == 4'b0110) begin
				if ( count == 227273 ) 
					count <= 19'b0000000000000000000;
				
				else
					count <= count + 1'b1;
				end // **
				
			else if ( v == 4'b0111) begin
				if ( count == 202478 ) 
					count <= 19'b0000000000000000000;
				
				else
					count <= count + 1'b1;
				end // **
			else if ( v == 4'b1000) begin
				if ( count == 191113 ) 
					count <= 19'b0000000000000000000;
					
				else
					count <= count + 1'b1;
				end // **
			else if ( v == 4'b1001) begin
				if ( count == 170262 ) 
					count <= 19'b0000000000000000000;
					
				else
					count <= count + 1'b1;
				end // **
			else if ( v == 4'b1010) begin
				if ( count == 151685 ) 
					count <= 19'b0000000000000000000;
					
				else
					count <= count + 1'b1;
				end // **
			else if ( v == 4'b1011) begin
				if ( count == 143172 ) 
					count <= 19'b0000000000000000000;
					
				else
					count <= count + 1'b1;
				end // **
			else if ( v == 4'b1100) begin
				if ( count == 127553 ) 
					count <= 19'b0000000000000000000;
					
				else
					count <= count + 1'b1;
				end // **
			else if ( v == 4'b1101) begin
				if ( count == 113636 ) 
					count <= 19'b0000000000000000000;
					
				else
					count <= count + 1'b1;
				end // **

			else if ( v == 4'b1110) begin
				if ( count == 101238 ) 
					count <= 19'b0000000000000000000;
				
				else
					count <= count + 1'b1;
				end // **
			else
					count <= 19'b0000000000000000000;		
			end //*
	end // ***

assign speaker = (count[18] | count[17] | count[16]);
//assign speaker = count[18];
		


endmodule




