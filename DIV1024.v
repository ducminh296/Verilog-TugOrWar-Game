`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: DIJIJI
// Engineer: GROUP 25
// 
// Create Date:     
// Design Name: 
// Module Name:    
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

module DIV1024(clk, rst, slowen1024);

	input clk, rst;
	output slowen1024;

	reg[9:0] counter;

	always @(posedge clk or posedge rst)
	begin
		if(rst) counter <= 10'b0000000000;
		else counter <= counter+1;
	end

	assign slowen1024 = &counter;

endmodule
	