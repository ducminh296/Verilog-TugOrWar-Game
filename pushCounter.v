`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:35:05 03/30/2011 
// Design Name: 
// Module Name:    pushCounter 
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
module pushCounter(
    input pbl,
    input pbr,
    input clk,
    input rst,
	 input speedRound,
	 input speedExit,
    output speed_tie,
    output speed_right
    );


reg[7:0] count_right, count_left;
reg right, tie;

//Synchronize our input signals
SYNC create_pblSync(.push(pbl),.clk(clk),.rst(rst),.sypush(pblSync));
OPP createPBL_pulse(.sypush(pblSync),.clk(clk),.rst(rst),.winrnd(PBL_pulse));

//Create one pulse per push for each signal
SYNC create_pbrSync(.push(pbr),.clk(clk),.rst(rst),.sypush(pbrSync));
OPP createPBR_pulse(.sypush(pbrSync),.clk(clk),.rst(rst),.winrnd(PBR_pulse));

//LEFT COUNTER
always@(posedge clk or posedge rst)
begin
	if(rst)count_left<=0;
	else if(speedExit)count_left<=0;
	else if(PBL_pulse & speedRound) count_left <= count_left+1;
	else count_left <= count_left;
end

//RIGHT COUNTER
always@(posedge clk or posedge rst)
begin
	if(rst)count_right<=0;
	else if(speedExit)count_right<=0;
	else if(PBR_pulse & speedRound) count_right <= count_right+1;
	else count_right <= count_right;
end

//COMPARE counters at end of speedRound
always@(posedge clk)
begin
	if(count_right > count_left )begin right=1; tie=0;end
	else if (count_right==count_left) begin right=0;tie=0; end
	else begin right=0; tie=0;end
end

//Output counter results
assign speed_right = right;
assign speed_tie = tie;

endmodule

		
		