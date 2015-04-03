module PBL(push,tie,right,pbl,pbr,rst,clr);

	input pbl,pbr,rst,clr;
	output push,tie,right;

	wire push,tie,right,pbl,pbr,rst,clr,pbl1,pbr1,G,H;

	assign pbl1 = pbl & ~G;
	assign pbr1 = pbr & ~H;

	rs_latch pbl_latch(G,pbl1,rst,clr);
	rs_latch pbr_latch(H,pbr1,rst,clr);

	assign push=G|H;
	assign tie=G&H;
	assign right=H&~G;
	
endmodule