`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: DIJIJI
// Engineer: GROUP 25
// 
// Create Date:  
// Design Name: 
// Module Name:    TOW
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
module tow(
    input pbr,
    input pbl,
    input CLK_I,
    input rst,
    output [6:0] Led
    );
//Complete wire signals needed below ???

wire clk;
wire clear, push, tie, right;	//for PushButtonLatch
wire sypush;	//for Sync
wire winrnd;	//for OPP
wire leds_on, fake; wire [6:0] score; wire [6:0] fake_score; wire speed_tie, speed_right, winspeed; //for SCORER
wire [2:0] led_control; wire [6:0] speed_led; // for led_mux
wire speed_round, speed_exit; // for pushCounter
wire slowen, slowen1024, slowen64;  // for DIV256, 1024, and 64
wire rand, randFake, randSpeed;  //For LFSR

//Slower Clock from 100Mhz to 500Hz -Given DO NOT remove 
clk_div createCLKdivide(.CLK_I(CLK_I),.rst(rst), .clk(clk));

//----------------------------------------------------------------------
//Instantiate PBL Sync OPP
PushButtonLatch createPushButtonLatch(.pbl(pbl), .pbr(pbr), .rst(rst), .clear(clear), .push(push), .tie(tie), .right(right) );
Sync createSync(.push(push), .clk(clk), .rst(rst), .sypush(sypush) );
OPP createOPP( .sypush(sypush), .clk(clk), .rst(rst), .winrnd(winrnd) );

//----------------------------------------------------------------------
//Instantiate scorer Led_Mux pushCounter
SCORER createScorer(.winrnd(winrnd), .right(right), .leds_on(leds_on), .tie(tie), .clk(clk), .rst(rst), .fake(fake), .score(score), .fake_score(fake_score), .speed_tie(speed_tie),.speed_right(speed_right), .winspeed(winspeed)); 
led_mux createLuxMux(.score(score), .led_control(led_control), .fake_score(fake_score), .speed_led(speed_led), .leds_out(Led) );
pushCounter createPushCounter(.pbl(pbl), .pbr(pbr), .clk(clk), .rst(rst), .speedRound(speed_round), .speedExit(speed_exit), .speed_tie(speed_tie), .speed_right(speed_right) );
//----------------------------------------------------------------------
//Div256 LFSR MC speed_controller
DIV256 createSLOWEN(.clk(clk), .rst(rst), .slowen(slowen));
DIV1024 createSLOWEN1024(.clk(clk), .rst(rst), .slowen1024(slowen1024));
DIV64 createSLOWEN64(.clk(clk), .rst(rst), .slowen64(slowen64));
LFSR createRAND(.clk(clk), .rst(rst), .rand(rand), .randFake(randFake), .randSpeed(randSpeed));
mc createMASTERCONTROLLER(.winrnd(winrnd), .slowen(slowen), .rand(rand), .randFake(randFake), .randSpeed(randSpeed), .clk(clk), .rst(rst), .speed_exit(speed_exit),.winspeed(winspeed), .speed_round(speed_round), .leds_on(leds_on), .clear(clear), .led_control(led_control), .fake(fake));
speed_controller speed_controller(.clk(clk), .rst(rst), .slowen(slowen), .slowen1024(slowen1024), .slowen64(slowen64), .speed_round(speed_round), .speed_tie(speed_tie), .speed_right(speed_right), .speed_led(speed_led), .winspeed(winspeed),.speed_exit(speed_exit));

endmodule
