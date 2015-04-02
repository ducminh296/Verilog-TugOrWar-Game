`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: DIJIJI
// Engineer: GROUP 25
// 
// Create Date:    
// Design Name: 
// Module Name:    DIV64 
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

module DIV64(clk, rst, slowen64);

	input clk, rst;
	output slowen64;

	reg[5:0] counter;

	always @(posedge clk or posedge rst)
	begin
		if(rst) counter <= 6'b000000;
		else counter <= counter+1;
	end

	assign slowen64 = &counter;

endmodule
	