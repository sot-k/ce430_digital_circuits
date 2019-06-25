`timescale 1ns/1ps

module testbench();

	reg clk = 0;
	parameter CLK_HALF_PERIOD = 10;
	reg reset;

	wire sample_ENABLE;
	reg [2:0]baud_select;
	wire[7:0] Rx_DATA;
	reg Rx_EN, RxD;

	uart_receiver myuart_receiver(.reset(reset), .clk(clk), .Rx_DATA(Rx_DATA), .baud_select(baud_select),
	.Rx_EN(Rx_EN), .RxD(RxD), .Rx_FERROR(Rx_FERROR), .Rx_PERROR(Rx_PERROR), .Rx_VALID(Rx_VALID));


	always begin
		#CLK_HALF_PERIOD clk = !clk;
	end

	initial begin
		reset = 0;
		baud_select = 3'b111;
		#100 reset = 1;
		RxD = 1'b1;
		#100 reset = 0;
		Rx_EN = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b1;
		#347520 reset = 1;
		RxD = 1'b1;
		#100 reset = 0;
		Rx_EN = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#347520 reset = 1;
		RxD = 1'b1;
		#100 reset = 0;
		Rx_EN = 1'b1;
		#10000RxD = 1'b0;
		#10000RxD = 1'b1;
		#10000RxD = 1'b0;
		#10000RxD = 1'b1;
		#10000RxD = 1'b0;
		#10000RxD = 1'b1;
		#10000RxD = 1'b0;
		#10000RxD = 1'b1;
		#10000RxD = 1'b0;
		#10000RxD = 1'b0;
		#10000RxD = 1'b1;
		#347520 reset = 1;
		RxD = 1'b1;
		#100 reset = 0;
		Rx_EN = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;

		#347520 reset = 1;
		RxD = 1'b1;
		#100 reset = 0;
		Rx_EN = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b0;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;

		#347520 reset = 1;
		RxD = 1'b1;
		#100 reset = 0;
		Rx_EN = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b0;
		#8640RxD = 1'b0;
		#8640RxD = 1'b0;
		#8640RxD = 1'b1;
		#8640RxD = 1'b1;
		#8640RxD = 1'b1;
		// Tx_DATA = 8'b01010101;
		// #100000000Tx_WR = 1'b1;
		// #100000000Tx_WR = 1'b0;
		// Tx_DATA = 8'b11001100;
		// #100000000Tx_WR = 1'b1;
		// #100000000Tx_WR = 1'b0;
		// Tx_DATA = 8'b10001001;
		// #100000000Tx_WR = 1'b1;
	end

endmodule
