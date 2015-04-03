`timescale 1ns / 1ps

module div64(clk,rst, slowen64);

	input clk,rst;
	output slowen64;

	reg[5:0] slowen_count;

	always @(posedge clk or posedge rst) 
	begin
		if (rst) slowen_count<=5'b00000;
		else slowen_count<=slowen_count+1;
	end

	assign slowen64=&slowen_count;
endmodule