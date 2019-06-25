`timescale 1ns/1ps

module testbench();

	reg [3:0] char;
	wire [6:0] LED;
	reg tb_clk,reset;
	parameter CLK_HALF_PERIOD = 10;

FourDigitLEDdriver mydriver(reset, clk, an3, an2, an1, an0, a, b, c, d, e, f, g, dp);

	always begin
		#CLK_HALF_PERIOD tb_clk = !tb_clk;
	end
	
	initial begin
			
		 reset = 0;
		#100 reset = 1;
		

		
	end
endmodule
