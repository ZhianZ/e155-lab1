/*
	name: Zhian Zhou
	email: zzhou@g.hmc.deu
	date:9/5/2024
*/

module lab1_top(
	input logic reset,
	input logic [3:0] s,
	output logic [2:0] led,
	output logic [6:0] seg
);
	logic int_osc;
	
	// Internal low-speed oscillator
	LSOSC OSCInst1 ( 
		.CLKLFEN(1'b1), 
		.CLKLFPU(1'b1), 
		.CLKLF(int_osc) 
	);
	
	// Instantiate seven_seg_decoder
	seven_seg_decoder inst1 (
		.s(s), 
		.seg(seg)
	);
	
	// Instantiate clock_divider
	clock_divider inst2 (
		.clk(int_osc),
		.reset(reset),
		.s(s),
		.led(led)
	);
	
	// Assign LED output logic
	assign led[0] = s[0] ^ s[1];
    assign led[1] = s[2] & s[3];

endmodule
