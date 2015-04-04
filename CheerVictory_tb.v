
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:06 04/03/2015 
// Design Name: 
// Module Name:    CheerVictory_tb 
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
module CheerVictory_tb;

	reg clk;
	reg rst;
	reg [6:0] score;
	reg isVictory;
	wire SyisVictory;
	wire wingame;
	wire [6:0] victory_led;
	
	always #20 clk <= ~clk;
	
	initial begin
		clk=0;rst=0;
		
		//reset
		@(posedge clk);
		#5; rst=1;
		@(posedge clk);
		#5; rst=0;
		
		
		score=7'b0000111;
		isVictory=1;
		
		#60;
		isVictory=0;
		#40;
		isVictory=1;
	end
	
	SYNC sync(.sypush(SyisVictory),.push(isVictory),.clk(clk),.rst(rst));
	OPP opp(.winrnd(wingame),.sypush(SyisVictory),.clk(clk),.rst(rst));
	CheerVictory chearVictory(.slowen512(clk),.score(score),.wingame(wingame),.victory_led(victory_led),.rst(rst));
	

endmodule
