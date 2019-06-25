`timescale 1ns/1ps

module testbench();

	reg clk = 0;
	parameter CLK_HALF_PERIOD = 10;
	reg reset;

	wire sample_ENABLE;
	reg [2:0]baud_select;

	baud_controller mybaud_controller(.reset(reset), .clk(clk), .baud_select(baud_select), .sample_ENABLE(sample_ENABLE));


	always begin
		#CLK_HALF_PERIOD clk = !clk;
	end

	initial begin
		reset = 0;
		baud_select = 3'b111;
		#100 reset = 1;
		#100 reset = 0;
		#1000000reset = 1;
		baud_select = 3'b110;
		#100 reset = 0;
		#1000000reset = 1;
		baud_select = 3'b101;
		#100 reset = 0;
		#1000000reset = 1;
		baud_select = 3'b100;
		#100 reset = 0;
		#1000000reset = 1;
		baud_select = 3'b011;
		#100 reset = 0;
		#1000000reset = 1;
		baud_select = 3'b010;
		#100 reset = 0;
		#1000000reset = 1;
		baud_select = 3'b001;
		#100 reset = 0;
		#1000000reset = 1;
		baud_select = 3'b000;
		#100 reset = 0;

	end

endmodule
