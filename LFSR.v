 `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: DIJIJI
// Engineer: GROUP 25
// 
// Create Date:  
// Design Name: 
// Module Name:    LFSR
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
 module LFSR(input clk, input rst, output rand, output randFake, output randSpeed);
 
 reg [9:0] LFSR;
 
 always @(posedge clk or posedge rst)begin
 
	if(rst) LFSR<=10'b1111111111;
	else begin
		LFSR[8:0]<=LFSR[9:1];
		LFSR[9]<=LFSR[9]^LFSR[2];
	end
 
 end
 
 assign rand = LFSR[2];
 assign randFake = LFSR[0] & LFSR[8];
 assign randSpeed = LFSR[5] & LFSR[1];
 
 endmodule