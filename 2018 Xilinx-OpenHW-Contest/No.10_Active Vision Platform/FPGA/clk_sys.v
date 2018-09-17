module clk_sys 
 (
  // Clock out ports
  output        clk_out1,
  output        clk_out2,
  output        clk_out3,
  // Status and control signals
  input         reset,
 // Clock in ports
  input         clk_in1
 );

  clk_sys_clk_wiz inst
  (
  // Clock out ports  
  .clk_out1(clk_out1),
  .clk_out2(clk_out2),
  .clk_out3(clk_out3),
  // Status and control signals               
  .reset(reset), 
 // Clock in ports
  .clk_in1(clk_in1)
  );

endmodule
