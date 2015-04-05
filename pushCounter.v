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
wire DC_L,DC_R,DW,pblSync1,pbrSync1,pblSync2,pbrSync2,PBL_pulse,PBR_pulse;
reg pblSync3,pbrSync3;
wire pbl_sync,pbr_sync;


//Synchronize input signals

//latch the data
SYNC create_pblSync1(pblSync1,pbl,clk,rst);
SYNC create_pbrSync1(pbrSync1,pbr,clk,rst);     


//latch the data again
SYNC create_pblSync2(pblSync2,pblSync1,clk,rst);
SYNC create_pbrSync2(pbrSync2,pbrSync1,clk,rst);

//comparator
assign DC_L=~(pblSync2^pblSync1);
assign DC_R=~(pbrSync2^pbrSync1);
assign DW=DC_L & DC_R;

//output
SYNC create_pblSync3(pbl_sync,pblSync3,clk,rst);
SYNC create_pbrSync3(pbr_sync,pbrSync3,clk,rst);

always @(DW) begin
   if (DW) begin
       pblSync3=pblSync2;
		 pbrSync3=pbrSync2;
	end else begin
	    pblSync3=pbl_sync;
		 pbrSync3=pbr_sync;
	end
end


OPP createPBL_pulse(PBL_pulse,pbl_sync,clk,rst); 
OPP createPBR_pulse(PBR_pulse,pbr_sync,clk,rst);





//LEFT COUNTER
always@ (posedge clk or posedge rst)
begin
	if(rst) count_left<=0;
	else if(speedExit) count_left<=0;
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
	if( count_right > count_left  )begin right=1; tie=0;end 
	else if(count_right == count_left)begin right=0; tie=1;end
	else begin right=0; tie=0;end
end

//Output counter results
assign speed_right = right;
assign speed_tie = tie; 

endmodule