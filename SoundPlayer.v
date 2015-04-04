`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:26 04/04/2015 
// Design Name: 
// Module Name:    SoundPlayer
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
module SoundPlayer(soundType, clk, rst, audio);

	input clk,rst;
	input [1:0] soundType;
	output audio;
	reg audio=0;
	
	parameter note_A = 100000000/512/2, note_D = 100000000/384/2, note_C = 100000000/431/2, note_G =100000000/271/2;
	reg [1:0] div = 2;
	
	reg [25:0] tone;
	reg [18:0] counter;
	
	always @(soundType)
	begin
		/* 0: Right button pushed; 
			1: Left button pushed
			2: SpeedRound sound;
			3: Wingame sound;
		*/
		case (soundType)
			0: div <= 1;
			1: div <= 1;
			2: div <= 2;
			default div <=1;
		endcase
	end
	
	always @(posedge clk or posedge rst) 
	begin
	
		if (rst) tone<=0;
		else tone <=tone+1;
		
		if(counter==0 |rst) counter <= (tone[25] ? note_A-1 : note_A/div -1); 
		else counter <= counter-1;
	end
	
	always @(posedge clk)
	begin
		if (counter==0) audio <=~audio;
	end
	
endmodule
