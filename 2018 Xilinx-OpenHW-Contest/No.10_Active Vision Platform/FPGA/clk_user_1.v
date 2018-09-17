
module clk_user_1 
 (
  // Clock out ports
  output        clk_out1,
  output        clk_out2,
  // Status and control signals
  input         reset,
 // Clock in ports
  input         clk_in1
 );

  clk_user_1_clk_wiz inst
  (
  // Clock out ports  
  .clk_out1(clk_out1),
  .clk_out2(clk_out2),
  // Status and control signals               
  .reset(reset), 
 // Clock in ports
  .clk_in1(clk_in1)
  );

endmodule
