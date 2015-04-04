`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:54:36 04/03/2015 
// Design Name: 
// Module Name:    CheerVictory 
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
module CheerVictory(slowen512, score, wingame, victory_led, rst);

	input wingame, slowen512;
	input wire [6:0] score;
	input rst;
	output reg [6:0] victory_led;
	reg right_vic;
	reg [3:0] count;
	
	always @(posedge slowen512)
	begin
		if (rst| wingame |count==12) count=0;
		else count= count+1;
		
		if (score==7'b0000111) right_vic=1;
		else right_vic=0;
	end
	
	always @(count or right_vic or score)
	begin
		case (count)
			0: begin
					if (right_vic) victory_led = 7'b0000111;
					else victory_led = 7'b1110000;
				end
			
			1: begin
					if (right_vic) victory_led = 7'b0000000;
					else victory_led = 7'b0000000;
				end
				
			2: begin
					if (right_vic) victory_led = 7'b0000111;
					else victory_led = 7'b1110000;
				end
				
			3: begin
					if (right_vic) victory_led = 7'b0000000;
					else victory_led = 7'b0000000;
				end
			
			4: begin
					if (right_vic) victory_led = 7'b0000111;
					else victory_led = 7'b1110000;
				end
				
			5: begin
					if (right_vic) victory_led = 7'b0000000;
					else victory_led = 7'b0000000;
				end
				
			
			6: begin
					if (right_vic) victory_led = 7'b1000000;
					else victory_led = 7'b0000001;
				end
				
			7: begin
					if (right_vic) victory_led = 7'b0100000;
					else victory_led = 7'b0000010;
				end
				
			8: begin
					if (right_vic) victory_led = 7'b0010000;
					else victory_led = 7'b0000100;
				end
				
			9: begin
					if (right_vic) victory_led = 7'b0001000;
					else victory_led = 7'b0001000;
				end
			10: begin
					if (right_vic) victory_led = 7'b0000100;
					else victory_led = 7'b0010000;
				end
				
			11: begin
					if (right_vic) victory_led = 7'b0000010;
					else victory_led = 7'b0100000;
				end
				
			12: begin
					if (right_vic) victory_led = 7'b0000001;
					else victory_led = 7'b1000000;
				end
			
			default: victory_led=score;
		endcase
	end
	
endmodule
