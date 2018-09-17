`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/14 21:11:22
// Design Name: 
// Module Name: pin_assign
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


module pin_assign(

    input sys_clk_p,
    input sys_clk_n,
    input CLK_50M_0,
    input CLK_50M_1,
    input CLK_50M_2,
    input CLK_50M_3,
    
    //SII9616
    output reg [35:0] PVI,
    output reg PVI_CLK,
    output reg PVI_DE,
    output reg PVI_HSYNC,
    output reg PVI_VSYNC,
    
    
    input [35:0] PVO,
    input PVO_CLK,
    input PVO_DE,
    input PVO_HSYNC,
    input PVO_VSYNC,
    input SII9616_INT,
    
    output DMD_RESETN,
    output DMD_SCPENZ,
    output DMD_SCPCK,
    output DMD_SCPDO,
    input  DMD_SCPDI,
    
    output [3:0] DAD_ADDR,
    output [1:0] DAD_SEL,
    output [1:0] DAD_MODE,
    output DAD_OEZ,
    output DAD_RESETN,
    output DAD_SCPENZ,
    output DAD_STROBE,

    //EIM
    inout [15:0] EIM_D,
    input EIM_OE,
    input EIM_CS0,
    output EIM_WAIT,
    input EIM_LBA,
    inout [15:0] EIM_DA,
    input EIM_RW,
    input EIM_BCLK,

    //IMAX_I2C
    input IMX_I2C_SCL,
    inout IMX_I2C_SDA,
    
    //UHP LAMP
    input LAMPEN_IMX,
    output LAMPEN_FPGA,

    //COLOR WHEEL
    input CW_INDEX,

    //PERIPHERALS
    output reg [3:0] LED,
    input [3:0] SWITCH,
    input [1:0] BUTTON
    );
	reg [3:0] EIM_IMX_LOW;
	reg [3:0] EIM_IMX_HIGH;
    assign EIM_DA [7:4] = EIM_IMX_LOW;
    assign EIM_DA [14:11] = EIM_IMX_HIGH;
    wire reset_n;
    assign reset_n = BUTTON[0];
    
    reg [71:0] VIDEO_BUFFER;
    reg [1:0] VIDEO_CLK;
    reg [1:0] VIDEO_DE;
    reg [1:0] VIDEO_HSYNC;
    reg [1:0] VIDEO_VSYNC;
    
    reg [22:0] count_1s;
    reg        clk_1;
    wire clk_200m_pr;
    wire clk_200m,clk_800m,clk_100m,clk_5m;
    wire clk_400m;
    wire reset;
    assign reset = ~reset_n;

IBUFDS #(
.DIFF_TERM("FALSE"), // Differential Termination
.IBUF_LOW_PWR("TRUE"), // Low power="TRUE", Highest perforrmance="FALSE"
.IOSTANDARD("DEFAULT") // Specify the input I/O standard
) IBUFDS_inst (
.O(clk_200m_pr), // Buffer output
.I(sys_clk_p), // Diff_p buffer input (connect directly to top-level port)
.IB(sys_clk_n) // Diff_n buffer input (connect directly to top-level port)
);

clk_sys clk_sys_inst
   (
    // Clock out ports
    .clk_out1(clk_200m),     // output clk_out1
    .clk_out2(clk_800m),     // output clk_out2
    .clk_out3(clk_400m),     // output clk_out3
    // Status and control signals
    .reset(reset), // input reset
   // Clock in ports
    .clk_in1(clk_200m_pr));        // input clk_in1
	
clk_user_1 clk_user_1_inst
   (
    // Clock out ports
    .clk_out1(clk_100m),     // output clk_out1
    .clk_out2(clk_5m),     // output clk_out2
    // Status and control signals
    .reset(reset), // input reset
   // Clock in ports
    .clk_in1(clk_200m));        // input clk_in1

// always@(posedge clk_5m or posedge reset)
// begin
// 	if(reset)
// 	begin
// 		count_1s <= 23'd0;
// 	end
// 	else
// 	begin
// 		if(count_1s == (5000000-1))
// 		begin count_1s <= 23'd0; clk_1 <= ~clk_1;end
// 		else
// 		begin count_1s <= count_1s +1;end
// 	end
// end	

    
// always@(posedge clk_1 or posedge reset)
// begin
// 	if(reset)
// 	begin
// 		LED <= 4'd0;
// 	end
// 	else
// 	begin
// 		LED <= LED + 4'd1;
// 	end
// end    

always@(posedge clk_5m or posedge reset)
begin
	if(reset)
	begin
		LED <= 4'd0;
	end
	else
	begin
		if(SWITCH == 4'b0000)begin 
			LED <= 4'b0000;
			EIM_IMX_LOW <= 4'b0000;
			EIM_IMX_HIGH <= 4'b0000;
		end
		else begin 
			LED <= 4'b1111;
			EIM_IMX_LOW <= 4'b0110;
			EIM_IMX_HIGH <= 4'b1011;
		end
	end
end	

always@(posedge clk_800m or posedge reset)
begin
	if(reset)
	begin
	   VIDEO_BUFFER <= 72'd0;
       VIDEO_CLK <= 2'd0;
       VIDEO_DE <= 2'd0;
       VIDEO_HSYNC <= 2'd0;
       VIDEO_VSYNC <= 2'd0;
	end
	else
	begin
		VIDEO_BUFFER <= {VIDEO_BUFFER[35:0], PVO[35:0]};
		VIDEO_CLK <= {VIDEO_CLK[0], PVO_CLK};
		VIDEO_DE <= {VIDEO_DE[0], PVO_DE};
		VIDEO_HSYNC <= {VIDEO_HSYNC[0], PVO_HSYNC};
		VIDEO_VSYNC <= {VIDEO_VSYNC[0], PVO_VSYNC};
		
		PVI <= VIDEO_BUFFER[71:36];
		PVI_CLK <= VIDEO_CLK[1];
		PVI_DE <= VIDEO_DE[1];
		PVI_HSYNC <= VIDEO_HSYNC[1];
		PVI_VSYNC <= VIDEO_VSYNC[1];		 
	end
end	
ila_0 ila_inst (
	.clk(clk_800m), // input wire clk


	.probe0(PVI), // input wire [35:0]  probe0  
	.probe1(PVI_CLK), // input wire [0:0]  probe1 
	.probe2(PVI_DE), // input wire [0:0]  probe2 
	.probe3(PVI_HSYNC), // input wire [0:0]  probe3 
	.probe4(PVI_VSYNC), // input wire [0:0]  probe4 
	.probe5(PVO), // input wire [35:0]  probe5 
	.probe6(PVO_CLK), // input wire [0:0]  probe6 
	.probe7(PVO_DE), // input wire [0:0]  probe7 
	.probe8(PVO_HSYNC), // input wire [0:0]  probe8 
	.probe9(PVO_VSYNC), // input wire [0:0]  probe9 
	.probe10(SII9616_INT) // input wire [0:0]  probe10
);
endmodule
