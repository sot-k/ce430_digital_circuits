module uart_receiver(reset, clk, Rx_DATA, baud_select, Rx_EN, RxD,
	Rx_FERROR, Rx_PERROR, Rx_VALID);
	input reset, clk;
	input [2:0] baud_select;
	input Rx_EN;
	input RxD;

	output [7:0] Rx_DATA;
	output Rx_FERROR; // Framing Error //
	output Rx_PERROR; // Parity Error //
	output Rx_VALID; // Rx_DATA is Valid //

	parameter START = 2'b00;
	parameter DATA = 2'b01;
	parameter PARITY = 2'b10;
	parameter STOP = 2'b11;

	reg Rx_FERROR, Rx_PERROR, Rx_VALID;
	reg[1:0] state;
	reg[7:0] Rx_DATA, sample_data;
	reg rxd_async;
	reg rxd_sync;
	reg[3:0] cycle_counter, byte_counter;
	reg parity_bit_sample, parity_bit;


	wire Rx_sample_ENABLE;

	baud_controller baud_controller_rx_instance(.reset(reset), .clk(clk),
			.baud_select(baud_select), .sample_ENABLE(Rx_sample_ENABLE));

	always @ (posedge Rx_sample_ENABLE) begin
		rxd_async = RxD;
	end

	always @ (posedge Rx_sample_ENABLE) begin
		rxd_sync = rxd_async;
	end

	always @ (posedge Rx_sample_ENABLE or posedge reset) begin
		if (reset) begin
			Rx_DATA = 7'b0000000;
			Rx_FERROR = 1'b0;
			Rx_PERROR = 1'b0;
			Rx_VALID = 1'b0;
			cycle_counter = 4'b0000;
			byte_counter = 0;
			sample_data = 7'b0000000;
			parity_bit_sample = 1'b0;
			parity_bit = 1'b0;
			state = START;
		end
		else if (Rx_EN)begin
			case (state)
				START: begin
					if(RxD == 1'b0 || cycle_counter != 4'b0000) begin
						if(cycle_counter == 4'b1111) begin
							state = DATA;
							byte_counter = 0;
							sample_data = 7'b0000000;
							parity_bit_sample = 1'b0;
							parity_bit = 1'b0;
							Rx_DATA = 7'b0000000;
							Rx_FERROR = 1'b0;
							Rx_PERROR = 1'b0;
							Rx_VALID = 1'b0;
						end
						else begin
							cycle_counter = cycle_counter + 1;
						end
					end
				end

				DATA: begin
					if (cycle_counter == 4'b1000) begin
						sample_data[byte_counter] = RxD;
						parity_bit = parity_bit ^ RxD;
						byte_counter = byte_counter + 1;
					end
					if ((byte_counter == 4'b1000) && (cycle_counter == 4'b1111)) begin
						state = PARITY;
					end
					if(cycle_counter == 4'b1111) begin
						cycle_counter = 4'b0000;
					end
					else begin
						cycle_counter = cycle_counter + 1;
					end
				end

				PARITY: begin
					if (cycle_counter == 4'b1000) begin
						parity_bit_sample = RxD;
					end
					if (cycle_counter == 4'b1111) begin
						state = STOP;
						cycle_counter = 4'b0000;
					end
					else begin
						cycle_counter = cycle_counter + 1;
					end
				end

				STOP: begin
					if (cycle_counter == 4'b1000) begin
						if (RxD) begin
							if (parity_bit == parity_bit_sample) begin
								Rx_DATA = sample_data;
								Rx_VALID = 1'b1;
								state = START;
								cycle_counter = 4'b0000;
							end
							else begin
								Rx_PERROR = 1'b1;
								state = START;
								cycle_counter = 4'b0000;
							end
						end
						else begin
							Rx_FERROR = 1'b1;
							state = START;
							cycle_counter = 4'b0000;
						end
					end
					else begin
						cycle_counter = cycle_counter + 1;
					end
				end
			endcase
		end

	end

endmodule
