module uart(reset, clk, baud_select, Rx_EN, Tx_EN, Tx_WR, Tx_DATA, Tx_BUSY, Rx_PERROR,
			Rx_FERROR, Rx_DATA, Rx_VALID);

	input reset, clk, Rx_EN, Tx_EN, Tx_WR;
	input[7:0] Tx_DATA;
	input[2:0] baud_select;

	output Tx_BUSY, Rx_PERROR, Rx_FERROR, Rx_VALID;
	output[7:0] Rx_DATA;

	wire data;

	uart_receiver myuart_receiver(.reset(reset), .clk(clk), .Rx_DATA(Rx_DATA), .baud_select(baud_select),
	.Rx_EN(Rx_EN), .RxD(data), .Rx_FERROR(Rx_FERROR), .Rx_PERROR(Rx_PERROR), .Rx_VALID(Rx_VALID));

	uart_transmitter myuart_transmitter(.reset(reset), .clk(clk), .Tx_DATA(Tx_DATA),
		.baud_select(baud_select), .Tx_WR(Tx_WR), .Tx_EN(Tx_EN), .TxD(data), .Tx_BUSY(Tx_BUSY));


endmodule
