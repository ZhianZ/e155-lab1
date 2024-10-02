/*
	name: Zhian Zhou
	email: zzhou@g.hmc.deu
	date:9/5/2024
*/

module clock_divider(
	input logic	clk,
	input logic reset,
	input logic [3:0] s,
	output logic [2:0] led
);
	
	logic [11:0] counter;
	
	// Simple clock divider
	always_ff @(posedge clk)
		begin
			if (reset == 0) counter <= 0;
			else counter <= counter + 1;
		end
	
	// Assign flashing LED output logic
	assign led[2] = counter[11];
	
endmodule