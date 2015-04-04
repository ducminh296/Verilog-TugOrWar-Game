`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:00:05 04/04/2015 
// Design Name: 
// Module Name:    SoundController
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
module SoundController(winrnd, wingame,slowen ,clk, audio, gain, notshutdown, rst);

	input winrnd, wingame, clk, rst, slowen;
	output audio,gain, notshutdown;
	reg notshutdown;
	wire gain,audio;
	reg [20:0] state, next_state;
	reg [1:0] soundType = 0; //1: button pushing sound; 2: winrnd sound; 3:speedRound sound; 4: wingame sound;
	parameter wait_for_signal=0, push_sound=1;
	
	
	SoundPlayer sound_player(.soundType(soundType),.clk(clk),.rst(rst),.audio(audio));
	
	always @(posedge clk or posedge rst) 
	begin	
		if (rst) state <= wait_for_signal;
		else state <= next_state;
	end
	
	always @(*)
	begin
		case (state)
			wait_for_signal: 
					begin
						if (rst) next_state=wait_for_signal;
						else if (winrnd) next_state=push_sound;
						else next_state=wait_for_signal;
					end
			push_sound: 	
					begin
						if (slowen) next_state=wait_for_signal;
						else next_state=push_sound;
					end
			default: next_state=wait_for_signal;
		endcase
	end
	
	always @(state)
	begin
		case (state)
			push_sound: 
				begin
					notshutdown=1;
					soundType=0;
				end
			
			default: notshutdown=0;
		endcase
	end

	assign gain=1; // gain is 6 dB
	
endmodule
