// updncounter.v - Written by Gord Allan Jan 30/2003 for 350 lab 3.
//////////////////////////////////////////////////////////////////////////////////
// Company: DIJIJI
// Engineer: GROUP 25
// 
// Create Date:  
// Design Name:
// Module Name:    UPDNCOUNTER
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
module updncounter(clk, rst, pbl, pbr, leds_out, status);	
	// We need to call the main pins in and out of our design the same as they are on the FPGA board
	input clk;				// from the clock pin on the function generator
	input rst;				// from the center push-button on the FPGA board
	input pbl;				// used for our count down control
	input pbr;				// used for our count up control
	output [6:0] leds_out;			// the lights on the FPGA board
	output [3:0] status;			// additional active low LEDS available for troubleshooting
	// Finally, as in any language, there are some declarations required.

	wire cntdwn_from_pushbutton;		
	wire cntup_from_pushbutton;		
	reg [6:0] counter;
	reg [6:0] next_count;
	reg cntdwn;
	reg cntup;

	// But, in our design they use different names, and so we must perform the mappings.

	assign status = 4'b1111;			// if the extra LEDS are not used turn them off
	assign cntdwn_from_pushbutton = pbl;		// map them to the external names
	assign cntup_from_pushbutton  = pbr;		// map them to the external names
	assign leds_out = counter;			// note that this will map all 7 bits

	always @(posedge clk or posedge rst)
		if(rst) counter <= 127;		// default notation is in decimal
		else counter <= next_count;

	// We use a seperate section to compute what value the counter should take on, based on the inputs.

	always @(counter or cntdwn or cntup) begin
		next_count = counter;
		if(cntdwn&~cntup)  next_count = counter - 1;
		if(~cntdwn&cntup)  next_count = counter + 1;
		
		end

	/*  
	But, there is a slight complication. 
	We can't just use the cntdown signal directly from the push-buttons.  
	The resoning will be covered more in the lectures.  
	We need to feed it through a flip-flop first.
	*/

	always @(posedge clk or posedge rst)
		if(rst) cntdwn <= 0;
		else cntdwn <= cntdwn_from_pushbutton;

	always @(posedge clk or posedge rst)
		if(rst) cntup <= 0;
		else cntup <= cntup_from_pushbutton;

endmodule

