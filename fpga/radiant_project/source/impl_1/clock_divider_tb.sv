/*
	name: Zhian Zhou
	email: zzhou@g.hmc.deu
	date:9/5/2024
*/

`timescale 1ns/1ns
`default_nettype none
`define N_TV 8

module seven_seg_decoder_tb();
 // Set up test signals
 logic clk, reset;
 logic [3:0] s;
 logic [2:0] led;

 // Instantiate the device under test
 clock_divider dut(.clk(clk), .reset(reset), .s(s), .led(led));

 // Generate clock signal with a period of 10 timesteps.
 always
   begin
     clk = 1; #5;
     clk = 0; #5;
   end
  
 // At the start of the simulation:
 //  - Load the testvectors
 //  - Pulse the reset line (if applicable)
 initial
   begin
     reset = 1; #27; reset = 0;
   end
  // Apply test vector on the rising edge of clk
  
endmodule