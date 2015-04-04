`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:00:54 04/04/2015 
// Design Name: 
// Module Name:    div512 
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
module div512(clk,rst, slowen512);

	input clk,rst;
	output slowen512;

	reg[8:0] slowen_count;

	always @(posedge clk or posedge rst) 
	begin
		if (rst) slowen_count<=9'b000000000;
		else slowen_count<=slowen_count+1;
	end

	assign slowen512=&slowen_count;
	
endmodule