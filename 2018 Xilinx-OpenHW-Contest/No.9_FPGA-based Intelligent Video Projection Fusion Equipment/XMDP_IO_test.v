`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Gavin
// 
// Create Date: 2017/12/15 15:41:19
// Design Name: 
// Module Name: XMDP
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


module XMDP(
    input sys_clk_p,
    input sys_clk_n,
    input clk50m_0,
    input nreset,
//    output reg [3:0] leds,
    output wire [3:0] leds,
    input [3:0] switches,
	
	//ddr3 ports
	output [13:0] ddr3_addr,
	output [2:0] ddr3_ba,	
	output ddr3_cas_n,
	output ddr3_ck_n,
	output ddr3_ck_p,
	output ddr3_cke,
	output ddr3_ras_n,
	output ddr3_reset_n,
	output ddr3_we_n,
	inout [63:0] ddr3_dq,
	inout [7:0] ddr3_dqs_n,
	inout [7:0] ddr3_dqs_p,

	output ddr3_cs_n,
	output [7:0] ddr3_dm,
	output ddr3_odt
    );
	
	

reg [22:0] count_1s;
reg        clk_1;
wire clk_200m_pr;
wire clk_200m,clk_800m,clk_100m,clk_5m;
wire clk_400m;
wire reset;
assign reset = ~nreset;



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
	
//clk_user_1 clk_user_1_inst
//   (
//    // Clock out ports
//    .clk_out1(clk_100m),     // output clk_out1
//    .clk_out2(clk_5m),     // output clk_out2
//    // Status and control signals
//    .reset(reset), // input reset
//   // Clock in ports
//    .clk_in1(clk_200m));        // input clk_in1
clk_user_2 clk_user_2_inst
   (
    // Clock out ports
    .clk_out1(clk_100m),     // output clk_out1
    .clk_out2(clk_5m),     // output clk_out2
    // Status and control signals
    .reset(reset), // input reset
   // Clock in ports
    .clk_in1(clk50m_0));        // input clk_in1


always@(posedge clk_5m or posedge reset)
begin
	if(reset)
	begin
		count_1s <= 23'd0;
	end
	else
	begin
		if(count_1s == (5000000-1))
		begin count_1s <= 23'd0; clk_1 <= ~clk_1;end
		else
		begin count_1s <= count_1s +1;end
	end
end	

    
//always@(posedge clk_1 or posedge reset)
//begin
//	if(reset)
//	begin
//		leds <= 4'd0;
//	end
//	else
//	begin
//	   if(switches==0)
//	       begin
//		      leds <= leds + 4'd1;
//		   end
//		else
//		  begin
//		  leds<=switches;
//		  end
//	end
//end    
assign leds = switches;


/* //switch controlled leds
always@(posedge clk_1 or posedge reset)
begin
	if(reset)
	begin
		leds <= 4'd0;
	end
	else
	begin
		leds <= switches;
	end
end  */  



wire init_calib_complete;


wire [27:0] app_addr;
wire [2:0] app_cmd;
wire app_en;
wire [511:0] app_wdf_data;
wire app_wdf_end;
wire app_wdf_wren;
wire [511:0] app_rd_data;
wire app_rd_data_end;
wire app_rd_data_valid;
wire app_rdy;
wire app_wdf_rdy;
wire app_sr_req,app_ref_req,app_zq_req;
wire app_sr_active,app_ref_ack,app_zq_ack;
wire ui_clk,ui_clk_sync_rst;
wire [63:0] app_wdf_mask;


wire ddr3_write_req;
wire [27:0] ddr3_wr_addr;
wire ddr3_write_done;
wire ddr3_read_req;
wire [27:0] ddr3_rd_addr;
wire ddr3_read_done;

wire ddr3_rdy; 

wire ddr3_wr_data_req;
wire [511:0] ddr3_wr_data;
wire ddr3_rd_data_valid;
wire [511:0] ddr3_rd_data;

//START==============================generate and receive the data======================
reg [511:0] gen_data;
wire [511:0] rec_data;
// reg [7:0] wr_count;//count 200 numbers
// reg [7:0] rd_count;
reg choose_wr_rd;

reg port_wr_req,port_rd_req;
reg [27:0] op_addr;

assign ddr3_write_req = port_wr_req;
assign ddr3_read_req = port_rd_req;

//receive 
//app_rd_data_valid
assign rec_data = app_rd_data;
//write
//ddr3_wr_data_req
assign ddr3_wr_data = gen_data;

assign ddr3_rd_addr = op_addr;
assign ddr3_wr_addr = op_addr;

reg [3:0] state_data_gen;
localparam state_select = 4'd0;
localparam state_write = 4'd1;
localparam state_read = 4'd2;

always@(posedge clk_200m or posedge reset)
begin
	if(reset)
	begin
	gen_data <= 512'd0;
	end
	else
	begin
	if(ddr3_wr_data_req)
	gen_data <= gen_data+512'd1;
	else
	gen_data <= gen_data;
	end
	
end

always@(posedge clk_200m or posedge reset)
begin
	if(reset)
	begin
	state_data_gen <= state_select;
	choose_wr_rd <= 1'd0;
	end
	else
	begin
		case(state_data_gen)
		state_select:
		begin
			if(ddr3_rdy)
			begin
			
			if(!choose_wr_rd)
			begin state_data_gen <= state_write;choose_wr_rd <= 1'd1;end
			else
			begin state_data_gen <= state_read;choose_wr_rd <= 1'd0;end
			
			end
			else
			begin
			state_data_gen <= state_select;
			end
		end
		state_write:
		begin
			if(ddr3_write_done)
			state_data_gen <= state_select;
			else
			state_data_gen <= state_write;
		end
		state_read:
		begin
			if(ddr3_read_done)
			state_data_gen <= state_select;
			else
			state_data_gen <= state_read;
		end
		default:
		begin
			state_data_gen <= state_select;
		end
		endcase
	end

end

always@(posedge clk_200m or posedge reset)
begin
	if(reset)
	begin
	port_wr_req <= 1'd0;
	port_rd_req <= 1'd0;
	op_addr <= 28'd0;

	end
	else
	begin
		case(state_data_gen)
		state_select:
		begin
			port_wr_req <= 1'd0;
			port_rd_req <= 1'd0;
			op_addr <= 28'd0;
		end
		state_write:
		begin
			port_wr_req <= 1'd1;
			port_rd_req <= 1'd0;
			op_addr <= 28'd0;
		end
		state_read:
		begin
			port_wr_req <= 1'd0;
			port_rd_req <= 1'd1;
			op_addr <= 28'd0;
		end
		default:
		begin
			port_wr_req <= 1'd0;
			port_rd_req <= 1'd0;
			op_addr <= 28'd0;
		end
		endcase
	end

end


// XILA_DATA_IN XILA_DATA_IN_INST (
	// .clk(clk_200m_pr), // input wire clk


	// .probe0(ddr3_wr_data), // input wire [511:0]  probe0  
    // .probe1(ddr3_wr_data_req), // input wire [0:0]  probe1 
    // .probe2(rec_data), // input wire [511:0]  probe2 
    // .probe3(app_rd_data_valid), // input wire [0:0]  probe3
	
	// .probe4(app_wdf_wren), // input wire [0:0]  probe4 
	// .probe5(app_en), // input wire [0:0]  probe5 
	// .probe6(app_rdy), // input wire [0:0]  probe6
	// .probe7(app_wdf_rdy) // input wire [0:0]  probe7
	
// );


//END==============================generate and receive the data======================

DDR3_manage DDR3_manage_inst(
		//ddr3 IP core interface==============================
    .app_addr(app_addr),  // output [27:0]		app_addr
    .app_cmd(app_cmd),  // output [2:0]		app_cmd
    .app_en(app_en),  // output				app_en
    .app_wdf_data(app_wdf_data),  // output [511:0]		app_wdf_data
    .app_wdf_end(app_wdf_end),  // output				app_wdf_end   
    .app_wdf_wren(app_wdf_wren),  // output				app_wdf_wren
    .app_sr_req(app_sr_req),  // output			app_sr_req
    .app_ref_req(app_ref_req),  // output			app_ref_req
    .app_zq_req(app_zq_req),  // output			app_zq_req
    .app_wdf_mask(app_wdf_mask),  // output [63:0]		app_wdf_mask
    
    
    .app_rd_data(app_rd_data),  // input [511:0]		app_rd_data
    .app_rd_data_end(app_rd_data_end),  // input			app_rd_data_end
    .app_rd_data_valid(app_rd_data_valid),  // input			app_rd_data_valid
    .app_rdy(app_rdy),  // input			app_rdy
    .app_wdf_rdy(app_wdf_rdy),  // input			app_wdf_rdy

    
    .app_sr_active(app_sr_active),  // input			app_sr_active
    .app_ref_ack(app_ref_ack),  // input			app_ref_ack
    .app_zq_ack(app_zq_ack),  // input			app_zq_ack
    .ui_clk(ui_clk),  // input			ui_clk
    .ui_clk_sync_rst(ui_clk_sync_rst),  // input			ui_clk_sync_rst
    
    
	
	
	.init_calib_complete(init_calib_complete),
	
    //add user interface==============================
    // add G
    .app_clk(clk_200m),   //system clock 200M
    .app_rst(reset),  
	
	.ddr3_write_req(ddr3_write_req),
	.ddr3_wr_addr(ddr3_wr_addr),
	.ddr3_write_done(ddr3_write_done),
	.ddr3_read_req(ddr3_read_req),
	.ddr3_rd_addr(ddr3_rd_addr),
	.ddr3_read_done(ddr3_read_done),
	
	
	.ddr3_rdy(ddr3_rdy),
	
	.ddr3_wr_data_req(ddr3_wr_data_req),
	.ddr3_wr_data(ddr3_wr_data),
	.ddr3_rd_data_valid(ddr3_rd_data_valid),
	.ddr3_rd_data(ddr3_rd_data)
	); 

	
	
XMDP_DDR3 u_XMDP_DDR3 (

    // Memory interface ports
    .ddr3_addr                      (ddr3_addr),  // output [13:0]		ddr3_addr
    .ddr3_ba                        (ddr3_ba),  // output [2:0]		ddr3_ba
    .ddr3_cas_n                     (ddr3_cas_n),  // output			ddr3_cas_n
    .ddr3_ck_n                      (ddr3_ck_n),  // output [0:0]		ddr3_ck_n
    .ddr3_ck_p                      (ddr3_ck_p),  // output [0:0]		ddr3_ck_p
    .ddr3_cke                       (ddr3_cke),  // output [0:0]		ddr3_cke
    .ddr3_ras_n                     (ddr3_ras_n),  // output			ddr3_ras_n
    .ddr3_reset_n                   (ddr3_reset_n),  // output			ddr3_reset_n
    .ddr3_we_n                      (ddr3_we_n),  // output			ddr3_we_n
    .ddr3_dq                        (ddr3_dq),  // inout [63:0]		ddr3_dq
    .ddr3_dqs_n                     (ddr3_dqs_n),  // inout [7:0]		ddr3_dqs_n
    .ddr3_dqs_p                     (ddr3_dqs_p),  // inout [7:0]		ddr3_dqs_p
    .init_calib_complete            (init_calib_complete),  // output			init_calib_complete
      
	.ddr3_cs_n                      (ddr3_cs_n),  // output [0:0]		ddr3_cs_n
    .ddr3_dm                        (ddr3_dm),  // output [7:0]		ddr3_dm
    .ddr3_odt                       (ddr3_odt),  // output [0:0]		ddr3_odt
    // Application interface ports
    .app_addr                       (app_addr),  // input [27:0]		app_addr
    .app_cmd                        (app_cmd),  // input [2:0]		app_cmd
    .app_en                         (app_en),  // input				app_en
    .app_wdf_data                   (app_wdf_data),  // input [511:0]		app_wdf_data
    .app_wdf_end                    (app_wdf_end),  // input				app_wdf_end
    .app_wdf_wren                   (app_wdf_wren),  // input				app_wdf_wren
    .app_rd_data                    (app_rd_data),  // output [511:0]		app_rd_data
    .app_rd_data_end                (app_rd_data_end),  // output			app_rd_data_end
    .app_rd_data_valid              (app_rd_data_valid),  // output			app_rd_data_valid
    .app_rdy                        (app_rdy),  // output			app_rdy
    .app_wdf_rdy                    (app_wdf_rdy),  // output			app_wdf_rdy
    .app_sr_req                     (app_sr_req),  // input			app_sr_req
    .app_ref_req                    (app_ref_req),  // input			app_ref_req
    .app_zq_req                     (app_zq_req),  // input			app_zq_req
    .app_sr_active                  (app_sr_active),  // output			app_sr_active
    .app_ref_ack                    (app_ref_ack),  // output			app_ref_ack
    .app_zq_ack                     (app_zq_ack),  // output			app_zq_ack
    .ui_clk                         (clk_200m_pr),  // output			ui_clk
    .ui_clk_sync_rst                (ui_clk_sync_rst),  // output			ui_clk_sync_rst
    .app_wdf_mask                   (app_wdf_mask),  // input [63:0]		app_wdf_mask
    // Debug Ports
    // .ddr3_ila_basic                 (ddr3_ila_basic),  // output [119:0]                               ddr3_ila_basic
    // .ddr3_ila_wrpath                (ddr3_ila_wrpath),  // output [390:0]                               ddr3_ila_wrpath
    // .ddr3_ila_rdpath                (ddr3_ila_rdpath),  // output [1023:0]                              ddr3_ila_rdpath
    // .ddr3_vio_sync_out              (ddr3_vio_sync_out),  // input [13:0]                                 ddr3_vio_sync_out
    // .dbg_pi_counter_read_val        (dbg_pi_counter_read_val),  // output [5:0]			dbg_pi_counter_read_val
    // .dbg_sel_pi_incdec              (dbg_sel_pi_incdec),  // input			dbg_sel_pi_incdec
    // .dbg_po_counter_read_val        (dbg_po_counter_read_val),  // output [8:0]			dbg_po_counter_read_val
    // .dbg_sel_po_incdec              (dbg_sel_po_incdec),  // input			dbg_sel_po_incdec
    // .dbg_byte_sel                   (dbg_byte_sel),  // input [3:0]			dbg_byte_sel
    // .dbg_pi_f_inc                   (dbg_pi_f_inc),  // input			dbg_pi_f_inc
    // .dbg_pi_f_dec                   (dbg_pi_f_dec),  // input			dbg_pi_f_dec
    // .dbg_po_f_inc                   (dbg_po_f_inc),  // input			dbg_po_f_inc
    // .dbg_po_f_stg23_sel             (dbg_po_f_stg23_sel),  // input			dbg_po_f_stg23_sel
    // .dbg_po_f_dec                   (dbg_po_f_dec),  // input			dbg_po_f_dec
    // System Clock Ports
    .sys_clk_p                       (sys_clk_p),  // input				sys_clk_p
    .sys_clk_n                       (sys_clk_n),  // input				sys_clk_n
    .sys_rst                        (reset) // input sys_rst
    );	
	
	
	
endmodule
