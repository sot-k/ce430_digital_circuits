`timescale 1ns/1ps

module testbench();

	reg clk = 0;
	parameter CLK_HALF_PERIOD = 10;
	reg reset;
	reg[13:0] address;
	wire[5:0]hpixel;

	integer i;

	always begin
		#CLK_HALF_PERIOD clk = !clk;
	end

	Vsync myVsync(.reset(reset), .clk(clk), .vpixel(hpixel), .vdeactivate(hdeactivate), .VGA_VSYNC(VGA_HSYNC));

	initial begin
		reset = 0;
		#(2*CLK_HALF_PERIOD)reset = 1;
		address = 14'b00000000000000;
		#(2*CLK_HALF_PERIOD)reset = 0;
	end
endmodule
