`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: DIJIJI
// Engineer: GROUP 25
// 
// Create Date:   
// Design Name: 
// Module Name:    DIV256
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

module DIV256(clk, rst, slowen);

	input clk, rst;
	output slowen;

	reg[7:0] counter;

	always @(posedge clk or posedge rst)
	begin
		if(rst) counter <= 8'b00000000;
		else counter <= counter+1;
	end

	assign slowen = &counter;

endmodule
	