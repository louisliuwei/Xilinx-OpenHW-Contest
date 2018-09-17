`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/08 12:06:43
// Design Name: 
// Module Name: XMDP_4port_video_inout_do
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module XMDP_4port_video_inout_do
(
    sys_clk_p,sys_clk_n,nreset,switches,
    
    rec_red,rec_green,rec_blue,
    rec_hsync,rec_vsync,rec_de,rec_clk,
    tra_red,tra_green,tra_blue,
    tra_hsync,tra_vsync,tra_de,tra_clk,
    
    rec_red_a2,rec_green_a2,rec_blue_a2,
    rec_hsync_a2,rec_vsync_a2,rec_de_a2,rec_clk_a2,
    tra_red_a2,tra_green_a2,tra_blue_a2,
    tra_hsync_a2,tra_vsync_a2,tra_de_a2,tra_clk_a2,
    
    leds
 ); 
input sys_clk_p;
input sys_clk_n;
input	nreset;																																									
input	[3:0]	switches;						
																											
input	[7:0]	rec_red;							
input	[7:0]	rec_green;					
input	[7:0]	rec_blue;						
input	rec_hsync;											
input	rec_vsync;											
input	rec_de;														
input	rec_clk;//66MHZ						
																											
output	[7:0]	tra_red;						
output	[7:0]	tra_green;				
output	[7:0]	tra_blue;					
output	tra_hsync;										
output	tra_vsync;										
output	tra_de;													
output	tra_clk;

input	[7:0]	rec_red_a2;							
input	[7:0]	rec_green_a2;					
input	[7:0]	rec_blue_a2;						
input	rec_hsync_a2;											
input	rec_vsync_a2;											
input	rec_de_a2;														
input	rec_clk_a2;//66MHZ						
																											
output	[7:0]	tra_red_a2;						
output	[7:0]	tra_green_a2;				
output	[7:0]	tra_blue_a2;					
output	tra_hsync_a2;										
output	tra_vsync_a2;										
output	tra_de_a2;													
output	tra_clk_a2;				
												
output	[3:0]	leds;																																				
           
reg [22:0] count_1s;
reg        clk_1;
wire clk_200m_pr;
wire clk_200m,clk_800m,clk_100m,clk_5m;
wire clk_400m;
wire clk_267m,clk_267m_inv;
wire reset;
assign reset = ~nreset;
       
assign  tra_red = rec_red;
assign  tra_green = rec_green;
assign  tra_blue = rec_blue;
assign  tra_hsync = rec_hsync;
assign  tra_vsync = rec_vsync;
assign  tra_de = rec_de;
assign  tra_clk = rec_clk;    

assign  tra_red_a2 = rec_red_a2;
assign  tra_green_a2 = rec_green_a2;
assign  tra_blue_a2 = rec_blue_a2;
assign  tra_hsync_a2 = rec_hsync_a2;
assign  tra_vsync_a2 = rec_vsync_a2;
assign  tra_de_a2 = rec_de_a2;
assign  tra_clk_a2 = rec_clk_a2;    
    
endmodule
