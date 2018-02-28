`timescale 1ns / 1ps
module music_notes(
	input wire clk,
	input wire countVariable,		// count variable accesses which part of 100 MHz signal will be used 
	input wire reset,
	input wire v,					// value for i to use correct value
	input wire out,
	output wire speaker
);

reg [countVariable - 1: 0] count;
if (out == 1'b1) begin
	always@(posedge clk) begin
		if (count == i[v] )
			count <= 0;
		else
			count <= count + 1;
	end
	assign speaker = counter[countVariable - 1];
end
else	
	assign speaker = counter[0];
endmodule