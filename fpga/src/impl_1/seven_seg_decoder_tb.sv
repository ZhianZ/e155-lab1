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
 logic [6:0] seg, seg_expected;
 logic [31:0] vectornum, errors;
 logic [10:0] testvectors[10000:0]; // Vectors of format s[3:0]_seg[6:0]

 // Instantiate the device under test
 seven_seg_decoder dut(.s(s), .seg(seg));

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
     testvectors[0] = 11'b0000_111_1110; // 0
	 testvectors[1] = 11'b0001_011_0000; // 1
	 testvectors[2] = 11'b0010_110_1101; // 2
	 testvectors[3] = 11'b0011_111_1001; // 3 
	 testvectors[4] = 11'b0100_011_0011; // 4
	 testvectors[5] = 11'b0101_101_1011; // 5
	 testvectors[6] = 11'b0110_101_1111; // 6
	 testvectors[7] = 11'b0111_111_0000; // 7
	 testvectors[8] = 11'b1000_111_1111; // 8
	 testvectors[9] = 11'b1001_111_1011; // 9
	 testvectors[10] = 11'b1010_111_0111; // A
	 testvectors[11] = 11'b1011_001_1111; // b
	 testvectors[12] = 11'b1100_100_1110; // C
	 testvectors[13] = 11'b1101_011_1101; // d
	 testvectors[14] = 11'b1110_100_1111; // E
	 testvectors[15] = 11'b1111_100_0111; // F
     vectornum = 0; errors = 0;
     reset = 1; #27; reset = 0;
   end
  // Apply test vector on the rising edge of clk
 always @(posedge clk)
   begin
       #1; {s, seg_expected} = testvectors[vectornum];
   end
  initial
 begin
   // Create dumpfile for signals
   $dumpfile("seven_seg_decoder_tb.vcd");
   $dumpvars(0, seven_seg_decoder_tb);
 end
  // Check results on the falling edge of clk
 always @(negedge clk)
   begin
     if (~reset) // skip during reset
       begin
         if (seg != seg_expected)
           begin
             $display("Error: inputs: s=%b", s);
             $display(" outputs: seg=%b (%b expected)", seg, seg_expected);
             errors = errors + 1;
           end

      
       vectornum = vectornum + 1;
      
       if (testvectors[vectornum] === 11'bx)
         begin
           $display("%d tests completed with %d errors.", vectornum, errors);
           $finish;
         end
     end
   end
endmodule