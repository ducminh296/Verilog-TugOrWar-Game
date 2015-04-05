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
	
	reg [1:0] div;
	reg [25:0] tone;
	reg [18:0] counter;
	reg [18:0] note;
	
	always @(soundType)
	begin
		/* 0: right_push_sound; div=1; note=note_A
			1: left_push_sound; div=1; note=note_D
			2: speed_round_sound; div=2; note=note_C
		*/
		note<=0;
		div<=2;
		case (soundType)
			0: begin
					div <= 1;
					note <= note_A;
				end
			1: begin
					div <= 1;
					note <= note_D;
				end
			2: begin
					div <= 2;
					note <= note_C;
				end
			default: 
				begin
					div <= 1;
					note <= note_A;
				end
		endcase
	end
	
	always @(posedge clk or posedge rst) 
	begin
	
		if (rst) tone<=0;
		else tone <=tone+1;
		
		if(counter==0 |rst) counter <= (tone[25] ? note-1 : note/div -1); 
		else counter <= counter-1;
	end
	
	always @(posedge clk)
	begin
		if (counter==0) audio <=~audio;
	end
	
endmodule
