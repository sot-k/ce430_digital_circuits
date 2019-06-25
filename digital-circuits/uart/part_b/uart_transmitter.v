module uart_transmitter(reset, clk, Tx_DATA, baud_select, Tx_WR, Tx_EN, TxD, Tx_BUSY);
	input reset, clk;
	input [7:0] Tx_DATA;
	input [2:0] baud_select;
	input Tx_EN;// ti tha kanw me auto? //
	input Tx_WR;

	output TxD;
	output Tx_BUSY;

	parameter IDLE = 3'b000;
	// in this phase uart_transmitter is doing nothing //
	// and waiting for an assignment in the form of Tx_WR = 1 //
	// also informs with the Tx_BUSY that a transmition is ongoing //
	parameter START = 3'b001;
	// in this phase uart_transmitter got an assignment and starts by //
	// sending the start_bit //
	parameter DATA = 3'b010;
	// this is the phase of the message transmition //
	parameter PARITY = 3'b011;
	// uart_transmitter ended with the message transmition and sends out //
	// the parity_bit //
	parameter STOP = 3'b100;
	// uart_transmitter sends the final(stop_bit) and informs with the reg //
	// Tx_BUSY that the transmition has ended //

	reg[4:0] tx_counter;
	reg[3:0] byte_counter;
	reg[7:0] data;
	reg[2:0] state;
	reg parity_bit;

	reg TxD, Tx_BUSY;

	wire Tx_sample_ENABLE;

	baud_controller baud_controller_tx_instance(.reset(reset), .clk(clk),
			.baud_select(baud_select), .sample_ENABLE(Tx_sample_ENABLE));

	always @(posedge Tx_sample_ENABLE or posedge reset) begin
		if (reset) begin
			tx_counter = 4'b0000;
			byte_counter = 3'b000;
			Tx_BUSY = 1'b0;
			data = 7'b0000000;
			state = IDLE;
			parity_bit = 1'b0;
			TxD = 1'b1;
		end
		else if (Tx_EN) begin
			if (tx_counter == 4'b1111) begin
				case (state)
					IDLE: begin
						if (Tx_WR == 1) begin
							Tx_BUSY = 1'b1;
							byte_counter = 3'b000;
							data = Tx_DATA;
							state = START;
							parity_bit = 1'b0;
						end
					end

					START: begin
						TxD = 1'b0;
						state = DATA;
					end

					DATA: begin
						TxD = data[byte_counter];
						parity_bit = parity_bit ^ data[byte_counter];
						if (byte_counter == 3'b111) begin
							state = PARITY;
						end
						else begin
							byte_counter = byte_counter + 1;
						end
					end

					PARITY: begin
						TxD = parity_bit;
						state = STOP;
					end

					STOP: begin
						TxD = 1'b1;
						Tx_BUSY = 1'b0;
						state = IDLE;
					end
				endcase
				tx_counter = 4'b0000;
			end
			else begin
				tx_counter = tx_counter + 1;
			end
		end
		else begin
			TxD = 1'b1;
		end
	end

endmodule
