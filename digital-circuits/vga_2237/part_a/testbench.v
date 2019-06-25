`timescale 1ns/1ps

module testbench();

	reg clk = 0;
	parameter CLK_HALF_PERIOD = 10;
	reg reset;
	reg[13:0] address;

	integer i;

	always begin
		#CLK_HALF_PERIOD clk = !clk;
	end

	mem mymem(.clk(clk), .reset(reset), .address(address), .red_out(red_out),
				.green_out(green_out), .blue_out(blue_out));

	initial begin
		reset = 0;
		#(2*CLK_HALF_PERIOD)reset = 1;
		address = 14'b00000000000000;
		#(2*CLK_HALF_PERIOD)reset = 0;
		for(i = 0; i<12288; i= i +1)begin
			#(2*CLK_HALF_PERIOD)address = address +1;
		end
	end
endmodule
