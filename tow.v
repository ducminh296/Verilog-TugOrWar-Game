`timescale 1ns / 1ps

module tow(
    input pbr,
    input pbl,
    input CLK_I,
    input rst,
    output [6:0] Led,
	 output audio,
	 output gain,
	 output notshutdown
    );
//Complete wire signals needed below ???
	wire 	clk,clear,push,tie,right,sypush,winrnd,leds_on,fake,Victory,Victory_sync,wingame;
	wire [6:0] score;
	wire [6:0] fake_score;
	wire speed_tie,speed_right,winspeed;
	wire [2:0] led_control;
	wire [6:0] speed_led;
	wire [6:0] victory_led;
	wire speed_round,speed_exit,slowen,slowen1024,slowen64,slowen512,rand,randFake,randSpeed;

//Slower Clock from 100Mhz to 500Hz -Given DO NOT remove 
clk_div createCLKdivide(.CLK_I(CLK_I),.rst(rst), .clk(clk));

//----------------------------------------------------------------------
//Instantiate PBL Sync OPP ??? 
PBL createPBL(
	.push(push),
	.tie(tie),
	.right(right),
	.pbl(pbl),
	.pbr(pbr),
	.rst(rst),
	.clr(clear));
SYNC sync_0(
	.sypush(sypush),
	.push(push),
	.clk(clk),
	.rst(rst));
OPP opp_0(
	.winrnd(winrnd),
	.sypush(sypush),
	.clk(clk),
	.rst(rst));
SYNC sync_1(
	.sypush(Victory_sync),
	.push(Victory),
	.clk(clk),
	.rst(rst));
OPP opp_1(
	.winrnd(wingame),
	.sypush(Victory_sync),
	.clk(clk),
	.rst(rst));
//----------------------------------------------------------------------
//Instantiate scorer Led_Mux pushCounter
scorer createScorer(
	.winrnd(winrnd),
	.right(right),
	.leds_on(leds_on),
	.tie(tie),
	.clk(clk),
	.rst(rst),
	.fake(fake),
	.score(score),
	.fake_score(fake_score),
	.speed_tie(speed_tie),
	.speed_right(speed_right),
	.winspeed(winspeed),
	.Victory(Victory));
	
CheerVictory cheerVictory(
	.wingame(wingame),
	.score(score),
	.slowen512(slowen512),
	.victory_led(victory_led),
	.rst(rst));
	
led_mux createLed_Mux(
	.score(score),
	.led_control(led_control),
	.fake_score(fake_score),
	.speed_led(speed_led),
	.leds_out(Led),
	.victory_led(victory_led));
	
pushCounter createpushCounter(
	.pbl(pbl),
	.pbr(pbr),
	.clk(clk),
	.rst(rst),
	.speedRound(speed_round),
	.speedExit(speed_exit),
	.speed_tie(speed_tie),
	.speed_right(speed_right));
//----------------------------------------------------------------------
//Div256 LFSR MC speed_controller
div256 createSlowen(
	.clk(clk),
	.rst(rst),
	.slowen256(slowen));
	
div512 createSlowen512(
	.clk(clk),
	.rst(rst),
	.slowen512(slowen512));
	
div1024 createSlowen1024(
	.clk(clk),
	.rst(rst),
	.slowen1024(slowen1024));
	
div64 createSlowen64(
	.clk(clk),
	.rst(rst),
	.slowen64(slowen64));
	
lfsr createRAND(
	.clk(clk),
	.rst(rst),
	.rand(rand), 
	.randFake(randFake), 
	.randSpeed(randSpeed));
mc createMASTERCONTROLLER(
	.winrnd(winrnd),
	.slowen(slowen),
	.rand(rand),
	.randFake(randFake),
	.randSpeed(randSpeed),
	.clk(clk),
	.rst(rst),
	.speed_exit(speed_exit),
	.winspeed(winspeed),
	.speed_round(speed_round),
	.leds_on(leds_on),
	.clear(clear),
	.led_control(led_control), 
	.fake(fake),
	.Victory(Victory));
speed_controller speed_controller(
	.clk(clk),
	.rst(rst),
	.slowen(slowen), 
	.slowen1024(slowen1024),
	.slowen64(slowen64),
	.speed_round(speed_round),
	.speed_tie(speed_tie),
	.speed_right(speed_right),
	.speed_led(speed_led),
	.winspeed(winspeed),
	.speed_exit(speed_exit));

SoundController sound_controller(
	.clk(CLK_I),
	.rst(rst),
	.winrnd(winrnd),
	.speed_round(speed_round),
	.wingame(wingame),
	.audio(audio),
	.gain(gain),
	.slowen(slowen),
	.notshutdown(notshutdown));
	
endmodule
