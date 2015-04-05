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
module SoundController(winrnd, push, right, speed_round, winspeed, slowen ,clk, audio, gain, notshutdown, rst);

	input winrnd, right, push, clk, rst, slowen ,speed_round, winspeed;
	output audio, gain, notshutdown;
	reg notshutdown;
	wire gain,audio;
	reg [1:0] state, next_state;
	reg [1:0] soundType = 0; 
	/*
		0: wait_for_signal; 
		1: right_push_sound; 
		2: left_push_sound; 
		3: speed_round_sound; 
	*/
	parameter 	wait_for_signal=0, 
					right_push_sound =1,
					left_push_sound =2,
					speed_round_sound=3,
					wingame_sound=4;
	
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
						else if (right & push & ~winrnd) next_state= right_push_sound;
						else if (~right & push & ~winrnd) next_state= left_push_sound; 
						else if (speed_round) next_state= speed_round_sound;
						else next_state=wait_for_signal;
					end
			right_push_sound: 	
					begin
						if (slowen) next_state=wait_for_signal;
						else next_state=right_push_sound;
					end
			left_push_sound: 	
					begin
						if (slowen) next_state=wait_for_signal;
						else next_state=left_push_sound;
					end
			speed_round_sound:
					begin
						if (~speed_round) next_state=wait_for_signal;
						else next_state=speed_round_sound;
					end
			default: next_state=wait_for_signal;
		endcase
	end
	
	always @(state)
	begin
		notshutdown<=1;
		/*
			0: right_push_sound; div=1; note=note_A
			1: left_push_sound; div=1; note=note_G
			2: speed_round_sound; div=2; note=note_C
		*/
		case (state)
			wait_for_signal: notshutdown<=0;	
			right_push_sound: soundType<=0;
			left_push_sound: soundType<=1;
			speed_round_sound: soundType<=2;
			default: soundType<=0;
		endcase
	end

	assign gain=1; // gain is 6 dB
	SoundPlayer sound_player(.soundType(soundType),.clk(clk),.rst(rst),.audio(audio));
endmodule
