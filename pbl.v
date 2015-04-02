//////////////////////////////////////////////////////////////////////////////////
// Company: DIJIJI
// Engineer: GROUP 25
// 
// Create Date:  
// Design Name: 
// Module Name:    PushButtonLatch
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
module PushButtonLatch( pbl, pbr, rst, clear, push, tie, right);
	input pbl, pbr, rst, clear;
	output push, tie, right;
	
	wire G, H;
	
	assign leftX = pbl & (~H);
	RSLatch leftLatch( .trigger(leftX), .rst(rst), .clear(clear), .Q(G) );
	
	assign rightX = pbr & (~G);
	RSLatch rightLatch( .trigger(rightX), .rst(rst), .clear(clear), .Q(H) );
	
	assign push = G | H;
	assign tie = G & H;
	assign right = H & ~G;
	
endmodule	