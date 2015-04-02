//////////////////////////////////////////////////////////////////////////////////
// Company: DIJIJI
// Engineer: GROUP 25
// 
// Create Date:  
// Design Name: 
// Module Name:    OPP
// Project Name: 	Group 25
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision:  - File Created
// Additional Comments: 
//////////////////////////////////////////////////////////////////////////////////
module OPP( sypush, clk, rst, winrnd );
	input sypush, clk, rst;
	output winrnd;
	
	wire winrnd;
	reg sypushQ;
	
	always @ ( posedge clk or posedge rst )
	begin
		if (rst) sypushQ <= 0;
		else sypushQ <= sypush;
	end
	
	assign winrnd = sypush & ~sypushQ;
endmodule 