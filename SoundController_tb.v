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
	
	reg winrnd,wingame,sypush,clk,rst;
	wire gain,audio,notshutdown,slowen;
	
	always #20 clk <= ~clk;
	div256 Clk_div(.clk(clk),.rst(rst),.slowen256(slowen));
	
	initial begin
		clk=0;rst=0;sypush=0;
		
		@(posedge clk);
		#5 rst=1;
		@(posedge clk);
		#5 rst=0;
		
		@(posedge clk);
		#5 winrnd=1;
		
		#60 winrnd=0;
		
	end
	
	SoundController soundcontroller(.winrnd(winrnd), .wingame(wingame),.slowen(slowen), .clk(clk),.audio(audio),.gain(gain),.notshutdown(notshutdown),.rst(rst),.slowen(slowen));
endmodule
