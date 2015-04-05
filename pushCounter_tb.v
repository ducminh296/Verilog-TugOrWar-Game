`timescale 1ns / 1ps

module pushCounter_tb;

	// Inputs
	reg pbl;
	reg pbr;
	reg clk;
	reg rst;
	reg speedRound;
	reg speedExit;

	// Outputs
	wire speed_tie;
	wire speed_right;

	// Instantiate the Unit Under Test (UUT)
	pushCounter uut (
		.pbl(pbl), 
		.pbr(pbr), 
		.clk(clk), 
		.rst(rst), 
		.speedRound(speedRound), 
		.speedExit(speedExit), 
		.speed_tie(speed_tie), 
		.speed_right(speed_right)
	);
	
always #10 clk <= ~clk;

	initial begin
		// Initialize Inputs
		pbl = 0;
		pbr = 0;
		clk = 0;
		rst = 0;
		speedRound = 0;
		speedExit = 0;
        
		// reset
		@(posedge clk);
		#2;
		rst=1;
		
		@(posedge clk);
		#2;
		rst=0;
		
		// Wait 100 ns for global reset to finish
		#100;
        
		@(posedge clk);
		#2;
		speedRound=1;
		
		
		//Press left 3 times
		repeat(5)@(posedge clk);#2;
		pbl=1;
		repeat(5)@(posedge clk);#2;
		pbl=0;
		repeat(5)@(posedge clk);#2;
		pbl=1;
		repeat(5)@(posedge clk);#2;
		pbl=0;
		repeat(5)@(posedge clk);#2;
		pbl=1;
		repeat(5)@(posedge clk);#2;
		pbl=0;
		
		//press right 2 times
		repeat(5)@(posedge clk);#2;
		pbr=1;
		repeat(5)@(posedge clk);#2;
		pbr=0;
		repeat(5)@(posedge clk);#2;
		pbr=1;
		repeat(5)@(posedge clk);#2;
		pbr=0;
		
		//press right 1 time,should be tie
		repeat(5)@(posedge clk);#2;
		pbr=1;
		repeat(5)@(posedge clk);#2;
		pbr=0;
		
		//press right 1 time,should be right win
		repeat(5)@(posedge clk);#2;
		pbr=1;
		repeat(5)@(posedge clk);#2;
		pbr=0;
	$finish;	
	end
	
	always @(pbl)	      $display("%t - DATAMONITOR: pbl signal changed to %b", $time, pbl);
	
	always @(pbr)	      $display("%t - DATAMONITOR: pbr signal changed to %b", $time, pbr);
	
	always @(rst)	      $display("%t - DATAMONITOR: rst signal changed to %b", $time, rst);
	
	always @(speed_right)	      $display("%t - DATAMONITOR: speed_right signal changed to %b", $time, speed_right);
	
	always @(speed_tie)	      $display("%t - DATAMONITOR: speed_tie signal changed to %b", $time, speed_tie);
	

endmodule