`timescale 1ns / 1ps
`include "clockSpeaker.v"
`include "clock_gen.v"
`include "BCD_to_Sseg_4Digits.v"

module Project(
	// input bits 
	// need input wire that can take 
	input wire k_clk,
	input wire k_dat,
	input wire clk,
	input wire clk_user,
	input wire reset,
	
	// output bits
	// need 
	//output reg [3:0] state,
	
	
	output wire AN2,
	output wire AN1,
	output wire AN3,
	output wire AN0,
	
	
	output reg out,
	output reg [3:0] state,
	output wire speaker,
	output wire [7:0] Sseg
);
// create  state and next state parameters 
// which sould be 4 bits a piece

wire [7:0] scancode;						// variable to hold 8 bits from key_dat
wire [7:0] s;	
wire [15:0] t;
reg [3:0] next_state;
reg [32:0] key_dat;							// 33 bit register to hold value of what key was pressed
//integer j [2:0] = {18,17,16};				// integer variable to hold where clock signal will be around
reg [3:0] store;							// integer value to hold index number 
													// store[1] holds state index which correlates to clock tics
													// store[0] stores j[0 , 1 , 2 ] which correlates to 
													// which signal to use 

// get value from keyboard
always@(negedge k_clk) begin
	key_dat = key_dat >> 1;
	key_dat[32] = k_dat;
end

// where bit 1 is beginning and bit 8 is end 

assign scancode = key_dat[8:1];
assign s = key_dat[19:12];

assign t = {s[7],s[6],s[5],s[4],s[3],s[2],s[1],s[0], scancode[7],scancode[6],scancode[5],scancode[4],scancode[3],scancode[2],scancode[1],scancode[0] };
BCD_to_Sseg_4Digits instance2 (t, AN3, AN2, AN1, AN0, Sseg);

clock_gen instance3 (
	.clkin(clk),
	.AN3(AN3),
	.AN2(AN2),
	.AN1(AN1),
	.AN0(AN0),
	.reset(reset)
	);


// create state machine that has 16 states
parameter [3:0] S0 = 4'b0000;					// silent state
parameter [3:0] S1 = 4'b0001;					// A or 1C or 0001 1100 C4 18
parameter [3:0] S2 = 4'b0010;					// S or 1B or 0001 1011 D4 18 
parameter [3:0] S3 = 4'b0011;					// D or 23 or 0010 0011 E4 18
parameter [3:0] S4 = 4'b0100;					// F or 2B or 0010 1011 F4 18
parameter [3:0] S5 = 4'b0101;					// Q or 15 or 0001 0101 G4 17
parameter [3:0] S6 = 4'b0110;					// W or 1D or 0001 1101 A4 17
parameter [3:0] S7 = 4'b0111;					// E or 24 or 0010 0100 B4 17
parameter [3:0] S8 = 4'b1000;					// R or 2D or 0010 1101 C5 17
parameter [3:0] S9 = 4'b1001;					// J or 3B or 0011 1011 D5 17
parameter [3:0] S10 = 4'b1010;					// K or 42 or 0100 0010 E5 17
parameter [3:0] S11 = 4'b1011;					// L or 4B or 0100 1011 F5 17
parameter [3:0] S12 = 4'b1100;					// ; or 4C or 0100 1100 G5 16
parameter [3:0] S13 = 4'b1101;					// U or 3C or 0011 1100 A5 16
parameter [3:0] S14 = 4'b1110;					// I or 43 or 0100 0011 B5 16
parameter [3:0] S15 = 4'b1111;					// output state
															// F0 which is 1111 0000
															
// if value sees F0 remain in that state until it does not 
// while button is pressed go into state 
// if button is pressed turn sound off 
//				

always@(state or scancode or s)begin
	case(state)
		S0: 	if (scancode == 8'b00000000) begin
					store = 4'b0000;	// 0 
					next_state = S0;
				end
				else if (s == 8'b00011100) begin
					
					store = 4'b0001;		// 1
					next_state = S15;
					end
				else if (scancode == 8'b00011011) begin
					store = 4'b0010;		// 2
					next_state = S15;
					end
				else if (scancode == 8'b00100011) begin
					store = 4'b0011;		// 3
					next_state = S15;
					end
				else if (scancode == 8'b00101011) begin
					store = 4'b0100;		// 4
					next_state = S15;
					end
				else if (scancode == 8'b00010101) begin
					store = 4'b0101;		// 5
					next_state = S15;
					end
				else if (scancode == 8'b00011101) begin
					store = 4'b0110;		// 6
					next_state = S15;
					end
				else if (scancode == 8'b00100100) begin
					store = 4'b0111;		// 7 
					next_state = S15;
					end
				else if (scancode == 8'b00101101) begin
					store = 4'b100;		// 8 
					next_state = S15;
					end
				else if (scancode == 8'b00111011) begin
					store = 4'b1001;		// 9
					next_state = S15;
					end
				else if (scancode == 8'b01000010) begin 
					store = 4'b1010;		// 10
					next_state = S15;
					end
				else if (scancode == 8'b01001011) begin
					store = 4'b1011;		// 11
					next_state = S15;
					end
				else if (scancode == 8'b01001100) begin
					store = 4'b1100;		// 12
					next_state = S15;
					end
				else if (scancode == 8'b00111100) begin
					store = 4'b1101;		// 13
					next_state = S15;
					end
				else if (scancode == 8'b01000011) begin 
					store = 4'b1110;		// 14
					next_state = S15;
					end 
				else
					next_state = S0;
					
		
					
		S15: next_state = S0;
		default: next_state = S0;
endcase	
if (state == 4'b1111)
	out = 1'b1;
else
	out = 1'b0;
end

// Create clock counter to get 33 pos edge for shifting into next state
reg [5:0] count;
always@(posedge k_clk ) begin
	if (count == 6'b100001) begin
		count <= 6'b000000;
		state = next_state;
		end
	else
		count <= count + 1'b1;		
end

	/*	
always@(posedge clk or negedge reset) begin
	if (~reset)
		// FILL CODE HERE to reset the state
		state = S0;
	else
		// FILL CODE HERE to update the current state with the next state
		state = next_state;
end
	*/
music_notes instance0 (clk,reset,store,out,speaker);	

// use bcd to see if out is changing between states, and on what value of store
//assign t = {store[3],store[2],store[1],store[0], 1'b0,1'b0,1'b0 ,out };
//BCD_to_Sseg_4Digits instance2 (t, AN3, AN2, AN1, AN0, Sseg);

endmodule
	