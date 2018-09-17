
module clk_sys_clk_wiz 

 (// Clock in ports
  // Clock out ports
  output        clk_out1,
  output        clk_out2,
  output        clk_out3,
  // Status and control signals
  input         reset,
  input         clk_in1
 );
  // Input buffering
  //------------------------------------
wire clk_in1_clk_sys;
wire clk_in2_clk_sys;
  IBUF clkin1_ibufg
   (.O (clk_in1_clk_sys),
    .I (clk_in1));


  wire        clk_out1_clk_sys;
  wire        clk_out2_clk_sys;
  wire        clk_out3_clk_sys;
  wire        clk_out4_clk_sys;
  wire        clk_out5_clk_sys;
  wire        clk_out6_clk_sys;
  wire        clk_out7_clk_sys;

  wire [15:0] do_unused;
  wire        drdy_unused;
  wire        psdone_unused;
  wire        locked_int;
  wire        clkfbout_clk_sys;
  wire        clkfbout_buf_clk_sys;
  wire        clkfboutb_unused;
    wire clkout0b_unused;
   wire clkout1b_unused;
   wire clkout2b_unused;
   wire clkout3_unused;
   wire clkout3b_unused;
   wire clkout4_unused;
  wire        clkout5_unused;
  wire        clkout6_unused;
  wire        clkfbstopped_unused;
  wire        clkinstopped_unused;
  wire        reset_high;

  MMCME2_ADV
  #(.BANDWIDTH            ("OPTIMIZED"),
    .CLKOUT4_CASCADE      ("FALSE"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT_F      (4.000),
    .CLKFBOUT_PHASE       (0.000),
    .CLKFBOUT_USE_FINE_PS ("FALSE"),
    .CLKOUT0_DIVIDE_F     (4.000),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT0_USE_FINE_PS  ("FALSE"),
    .CLKOUT1_DIVIDE       (2),
    .CLKOUT1_PHASE        (0.000),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .CLKOUT1_USE_FINE_PS  ("FALSE"),
    .CLKOUT2_DIVIDE       (1),
    .CLKOUT2_PHASE        (0.000),
    .CLKOUT2_DUTY_CYCLE   (0.500),
    .CLKOUT2_USE_FINE_PS  ("FALSE"),
    .CLKIN1_PERIOD        (5.000))
  mmcm_adv_inst
    // Output clocks
   (
    .CLKFBOUT            (clkfbout_clk_sys),
    .CLKFBOUTB           (clkfboutb_unused),
    .CLKOUT0             (clk_out1_clk_sys),
    .CLKOUT0B            (clkout0b_unused),
    .CLKOUT1             (clk_out2_clk_sys),
    .CLKOUT1B            (clkout1b_unused),
    .CLKOUT2             (clk_out3_clk_sys),
    .CLKOUT2B            (clkout2b_unused),
    .CLKOUT3             (clkout3_unused),
    .CLKOUT3B            (clkout3b_unused),
    .CLKOUT4             (clkout4_unused),
    .CLKOUT5             (clkout5_unused),
    .CLKOUT6             (clkout6_unused),
     // Input clock control
    .CLKFBIN             (clkfbout_buf_clk_sys),
    .CLKIN1              (clk_in1_clk_sys),
    .CLKIN2              (1'b0),
     // Tied to always select the primary input clock
    .CLKINSEL            (1'b1),
    // Ports for dynamic reconfiguration
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (do_unused),
    .DRDY                (drdy_unused),
    .DWE                 (1'b0),
    // Ports for dynamic phase shift
    .PSCLK               (1'b0),
    .PSEN                (1'b0),
    .PSINCDEC            (1'b0),
    .PSDONE              (psdone_unused),
    // Other control and status signals
    .LOCKED              (locked_int),
    .CLKINSTOPPED        (clkinstopped_unused),
    .CLKFBSTOPPED        (clkfbstopped_unused),
    .PWRDWN              (1'b0),
    .RST                 (reset_high));
  assign reset_high = reset; 



  BUFG clkf_buf
   (.O (clkfbout_buf_clk_sys),
    .I (clkfbout_clk_sys));






  BUFG clkout1_buf
   (.O   (clk_out1),
    .I   (clk_out1_clk_sys));


  BUFG clkout2_buf
   (.O   (clk_out2),
    .I   (clk_out2_clk_sys));

  BUFG clkout3_buf
   (.O   (clk_out3),
    .I   (clk_out3_clk_sys));



endmodule
