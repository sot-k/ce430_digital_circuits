`timescale 1ns/1ps

module testbench();

	reg clk = 0;
	parameter CLK_HALF_PERIOD = 10;
	reg reset;

	wire sample_ENABLE;
	reg [2:0]baud_select;
	reg[7:0] Tx_DATA;
	reg Tx_WR, Tx_EN;

	uart_transmitter myuart_transmitter(.reset(reset), .clk(clk), .Tx_DATA(Tx_DATA),
		.baud_select(baud_select), .Tx_WR(Tx_WR), .Tx_EN(Tx_EN), .TxD(TxD), .Tx_BUSY(Tx_BUSY));


	always begin
		#CLK_HALF_PERIOD clk = !clk;
	end

	initial begin
		reset = 0;
		baud_select = 3'b111;
		#100 reset = 1;
		#100 reset = 0;
		Tx_EN = 1'b1;
		Tx_DATA = 8'b10101010;
		Tx_WR = 1'b1;
		#102000Tx_WR = 1'b0;
		Tx_DATA = 8'b01010101;
		#102000Tx_WR = 1'b1;
		#102000Tx_WR = 1'b0;
		Tx_DATA = 8'b11001100;
		#102000Tx_WR = 1'b1;
		#102000Tx_WR = 1'b0;
		Tx_DATA = 8'b10001001;
		#102000Tx_WR = 1'b1;
	end

endmodule
