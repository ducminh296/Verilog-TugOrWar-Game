module OPP(winrnd,sypush,clk,rst);
	input sypush,clk,rst;
	output winrnd;
	wire sypush,clk,rst,winrnd;
	reg Q;

	assign winrnd=sypush&~Q;

	always @(posedge clk or posedge rst)
	begin
		if (rst) Q<=0;
		else Q<=sypush;
	end
endmodule