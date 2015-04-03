`timescale 1ns / 1ps

module div256(clk,rst, slowen256);

	input clk,rst;
	output slowen256;

	reg[7:0] slowen_count;

	always @(posedge clk or posedge rst) 
	begin
		if (rst) slowen_count<=8'b00000000;
		else slowen_count<=slowen_count+1;
	end

	assign slowen256=&slowen_count;
endmodule