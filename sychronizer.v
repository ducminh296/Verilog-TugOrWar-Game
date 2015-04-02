//////////////////////////////////////////////////////////////////////////////////
// Company: DIJIJI
// Engineer: GROUP 25
// 
// Create Date:  
// Design Name: 
// Module Name:    SYNCHRONIZER
// Project Name: 	Group 25
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision:  - File Created
//
//////////////////////////////////////////////////////////////////////////////////
module Sync( push, clk, rst, sypush);
	input push, clk, rst;
	output sypush;
	
	reg sypush;
	
	always @(posedge clk or posedge rst)
	begin
		if(rst) sypush <= 0;
		else sypush <= push;
	end

endmodule 