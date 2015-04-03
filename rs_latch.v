module rs_latch(Q, trigger, rst, clr);

	input trigger, rst, clr;
	output Q;

	wire trigger,x,rst,clr,Q;

	assign x=trigger|Q;
	assign Q=x&~(rst|clr);

endmodule