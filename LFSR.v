`timescale 1ns / 1ps

module lfsr(clk,rst,rand,randFake,randSpeed);
	
	input clk,rst;
	output rand,randFake,randSpeed;

	reg[9:0] Q;

	always @(posedge clk or posedge rst)
	begin
		if (rst) Q<=10'b1111111111;
		else begin
				Q[8:0]<=Q[9:1];
				Q[9]<=Q[2]^Q[5];
			end
	end

	assign rand=Q[2];
	
	assign randFake=Q[6]&Q[3];
	assign randSpeed=Q[8]&Q[4];
endmodule
