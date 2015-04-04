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
	
	parameter note_A = 100000000/440/2;
	
	//reg [25:0] tone;
	reg [18:0] counter;
	always @(posedge clk or posedge rst) 
	begin
	
		//if (rst) tone<=0;
		//else tone<=tone+1;
		
		if (counter == note_A | rst) 
			begin
				counter <=0;
				audio <= ~audio;
			end
			else counter <= counter + 1;
	end
	
endmodule
