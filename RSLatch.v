//////////////////////////////////////////////////////////////////////////////////
// Company: DIJIJI
// Engineer: GROUP 25
// 
// Create Date:  
// Design Name: 
// Module Name:    RSLatch
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
module RSLatch( trigger, rst, clear, Q );
	input trigger, rst, clear;
	output Q;
	
	assign x = trigger | Q;
	assign Q = x & ~(rst | clear);
	
endmodule