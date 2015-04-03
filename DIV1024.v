`timescale 1ns / 1ps

module div1024(clk,rst, slowen1024);

	input clk,rst;
	output slowen1024;

	reg[9:0] slowen_count;

	always @(posedge clk or posedge rst) 
	begin
		if (rst) slowen_count<=9'b000000000;
		else slowen_count<=slowen_count+1;
	end

	assign slowen1024=&slowen_count;
endmodule