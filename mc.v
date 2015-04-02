`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 	DIJIJI
// Engineer:	GROUP 25 
// 
// Create Date:    
// Design Name: 
// Module Name:    MASTER CONTROLLER
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
module mc(winrnd,slowen,rand, randFake, randSpeed,clk,rst,speed_exit,winspeed,speed_round,leds_on,clear,led_control,fake);

input winrnd;
input slowen;
input rand;
input clk;
input rst;
input randFake; //for fake state
input randSpeed; //for speed round
input winspeed; //turn off speed_round\
input speed_exit;
output reg speed_round;
output reg leds_on;
output reg clear;
output reg [2:0] led_control;
output reg fake;
wire fake_timeout; //high after designated wait time
reg [1:0] slowen_count; //counts slowen
reg [3:0] state, next_state;

parameter reset=0, wait_a=1, wait_b=2, dark=3,play=4,gloat_a=5,gloat_b=6, ERROR=7, fake_play=8, speed_play=9, speed_play_display=10;

always @(posedge clk or posedge rst) begin
	if(rst) state <= reset;		//__Changed to non-blocking <=
	else state <= next_state;	//__Changed to non-blocking <=
end
//*********CREATING FAKE timeout*****************//
always @(posedge slowen or posedge rst) begin
 //Complete code here so that fake_timeout is high after 2 seconds ??????
	if(rst) slowen_count <=reset;
	else slowen_count <= slowen_count+1; //__
end
assign fake_timeout = &slowen_count;
//******************************************//

always @(state or winrnd or slowen or rand or randSpeed or rst or randFake or fake_timeout or winspeed or speed_exit )begin //some signals missing in always block sensitivity list  ???????
	case(state)
		reset: begin
			if (rst) next_state <= reset;
			else next_state <= wait_a;
		end
		wait_a: begin
			if (slowen) next_state <= wait_b;
			else next_state <= wait_a;
		end
		wait_b: begin
			if(slowen) next_state <= dark;
			else next_state <= wait_b;
		end
		dark: begin
			if(slowen & randFake & ~rand) next_state <= fake_play;
			else if(slowen & randSpeed & ~rand & ~randFake) next_state <= speed_play;
			else if (slowen & rand) next_state <= play;
			else if (winrnd) next_state <= gloat_a;
			else next_state <= dark;
		end
		fake_play: begin
			if(winrnd & fake_timeout) next_state <= gloat_a;
			else if(fake_timeout) next_state <= dark;
			else next_state <= fake_play;
		end
		speed_play: begin
			if(winspeed) next_state <= speed_play_display;
			else next_state <= speed_play;
		end
		speed_play_display: begin
			if(speed_exit) next_state <= gloat_a;
			else next_state <= speed_play_display;
		end
		play: begin
			if(winrnd) next_state <= gloat_a;
			else next_state <= play;
		end
		gloat_a: begin
			if(slowen) next_state <= gloat_b;
			else next_state <= gloat_a;
		end
		gloat_b: begin
			if(slowen) next_state <= wait_b;
			else next_state <= gloat_b;
		end
		ERROR: next_state <= reset; //reset if error occurred (somehow in 8th state)
		default: next_state <= reset;
	endcase
end

//output 
always @(state)
	case(state)
		//led control states: (check what your LED Mux is set to display) ??????????
		// 000 - dark
		//  001 - Reset 
		//  010 - All on
		//  011 show score!
		//  100 - fake score
		//	110 - speed led
		
		
		//Complete Output for each for 10 state ??????
		reset: begin leds_on <= 1; clear <= 1; led_control <= 3'b001; fake <= 0; speed_round <= 0; end
		wait_a: begin leds_on <= 1; clear <= 1; led_control <= 3'b010; fake <= 0; speed_round <= 0; end
		wait_b: begin	leds_on <= 1; clear <= 1; led_control <= 3'b010; fake <= 0; speed_round <= 0; end
		dark: begin	leds_on <= 0; clear <= 0; led_control <= 3'b000; fake <= 0; speed_round <= 0; end
		fake_play: begin	leds_on <= 1; clear <= 0; led_control <= 3'b100; fake <= 1; speed_round <= 0; end
		speed_play: begin	leds_on <= 1; clear <= 1; led_control <= 3'b010; fake <= 0; speed_round <= 1; end
		play: begin leds_on <= 1; clear <= 0; led_control <= 3'b011; fake <= 0; speed_round <= 0; end
		speed_play_display: begin	leds_on <= 1; clear <= 1; led_control <= 3'b110; fake <= 0; speed_round <= 0; end
		gloat_a: begin	leds_on <= 1; clear <= 1; led_control <= 3'b011; fake <= 0; speed_round <= 0; end
		gloat_b: begin	leds_on <= 1; clear <= 1; led_control <= 3'b011; fake <= 0; speed_round <= 0; end
		ERROR:   begin leds_on <= 1; clear <= 1; led_control <= 3'b001; fake <= 0; speed_round <= 0; end
		default: begin leds_on <= 1; clear <= 1; led_control <= 3'b001; fake <= 0; speed_round <= 0; end
	endcase
endmodule
