`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:06:01 04/04/2015 
// Design Name: 
// Module Name:    SoundGenerator_tb 
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
module SoundController_tb();
	
	reg winrnd,wingame,push,right,sypush,clk,rst,speed_round,winspeed;
	wire gain,audio,notshutdown,slowen;
	
	always #20 clk <= ~clk;
	div256 Clk_div(.clk(clk),.rst(rst),.slowen256(slowen));
	
	initial begin
		clk=0;rst=0;sypush=0;speed_round=0;winspeed=0;push=0;right=0;
		
		@(posedge clk);
		#5 rst=1;
		@(posedge clk);
		#5 rst=0;
		
		/*
		@(posedge clk);
		#5 winrnd=1;
		
		#60 winrnd=0;
		*/
		
		
		@(posedge clk);
		#5 wingame=1;
		
		#60
		@(posedge clk);
		wingame=0;
		
		
	end
	
	SoundController soundcontroller(.winrnd(winrnd),.push(push),.right(right),.speed_round(speed_round),.winspeed(winspeed), .wingame(wingame), .clk(clk),.audio(audio),.gain(gain),.notshutdown(notshutdown),.rst(rst),.slowen(slowen));
endmodule
