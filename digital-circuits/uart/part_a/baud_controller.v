module baud_controller(reset, clk, baud_select, sample_ENABLE);
	input reset, clk;
	input [2:0] baud_select;
	output sample_ENABLE;

	reg[13:0] cycle_counter;
	reg sample_ENABLE;

	always @(posedge clk or negedge reset) begin
		if (reset) begin
			sample_ENABLE = 0;
			cycle_counter = 14'b00000000000000;
		end
		else begin
			if (cycle_counter == 14'b00000000000000) begin
				sample_ENABLE = 0;
			end

			cycle_counter = cycle_counter + 1;

			case (baud_select)// selecting the frequency according to the wanted baud transmition rate //
				3'b000: begin
					if (cycle_counter == 14'b10100010110001) begin
						sample_ENABLE = 1;
						cycle_counter = 14'b00000000000000;
					end
				end
				3'b001: begin
					if (cycle_counter == 14'b00101000101100) begin
						sample_ENABLE = 1;
						cycle_counter = 14'b00000000000000;
					end
				end
				3'b010: begin
					if (cycle_counter == 14'b00001010001011) begin
						sample_ENABLE = 1;
						cycle_counter = 14'b00000000000000;
					end
				end
				3'b011: begin
					if (cycle_counter == 14'b00000101000110) begin
						sample_ENABLE = 1;
						cycle_counter = 14'b00000000000000;
					end
				end
				3'b100: begin
					if (cycle_counter == 14'b00000010100011) begin
						sample_ENABLE = 1;
						cycle_counter = 14'b00000000000000;
					end
				end
				3'b101: begin
					if (cycle_counter == 14'b00000001010001) begin
						sample_ENABLE = 1;
						cycle_counter = 14'b00000000000000;
					end
				end
				3'b110: begin
					if (cycle_counter == 14'b00000000110110) begin
						sample_ENABLE = 1;
						cycle_counter = 14'b00000000000000;
					end
				end
				3'b111: begin
					if (cycle_counter == 14'b00000000011011) begin
						sample_ENABLE = 1;
						cycle_counter = 14'b00000000000000;
					end
				end
			endcase
		end
	end

endmodule
