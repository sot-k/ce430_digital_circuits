`timescale 1ns/1ps

module testbench();

	reg clk = 0;
	parameter CLK_HALF_PERIOD = 10;
	reg reset,button;

FourDigitLEDdriver myDriver(.reset(reset), .clk(clk),
						.an3(an3), .an2(an2), .an1(an1),.an0(an0), .a(a),
						.b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .dp(dp));

	always begin
		#CLK_HALF_PERIOD clk = !clk;
	end

	initial begin
		reset = 1;
		#100 reset = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;
		#6400 button = 1;
		#640 button = 0;


		#1000000$finish;
	end
endmodule
