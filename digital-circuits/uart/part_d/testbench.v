`timescale 1ns/1ps

module testbench();

	integer i;

	reg clk = 0;
	parameter CLK_HALF_PERIOD = 10;
	reg reset;
	reg[7:0]mem[0:3];

	reg Rx_EN, Tx_EN, Tx_WR;
	reg[7:0] Tx_DATA;
	reg[2:0] baud_select;

	wire Tx_BUSY, Rx_PERROR, Rx_FERROR, Rx_VALID;
	wire[7:0] Rx_DATA;

	uart myuart(.reset(reset), .clk(clk), .baud_select(baud_select), .Rx_EN(Rx_EN),
				.Tx_EN(Tx_EN), .Tx_WR(Tx_WR), .Tx_DATA(Tx_DATA), .Tx_BUSY(Tx_BUSY),
				.Rx_PERROR(Rx_PERROR), .Rx_FERROR(Rx_FERROR), .Rx_DATA(Rx_DATA),
				.Rx_VALID(Rx_VALID));


	always begin
		#CLK_HALF_PERIOD clk = !clk;
	end

	initial begin
		mem[0] = 8'b10101010;
		mem[1] = 8'b01010101;
		mem[2] = 8'b11001100;
		mem[3] = 8'b10001001;
		reset = 0;
		baud_select = 3'b111;
		Rx_EN = 1'b1;
		Tx_EN = 1'b1;
		Tx_WR = 1'b0;
		#100 reset = 1;
		#100 reset = 0;
		for(i = 0; i<4; i= i +1)begin
			while (Tx_BUSY) begin
				#1000Tx_WR = 1'b0;
			end
			Tx_DATA = mem[i];
			Tx_WR = 1'b1;
			#10800Tx_WR = 1'b0;


		end

	end

endmodule
