module resetmanager(clk, reset, reset_out);

	input clk, reset;
	output reset_out;
	
	reg reset_out;
	reg[1:0] reset_count;
	
	always @(posedge clk or posedge reset) begin
		
		if(reset) begin
			reset_out = 1;
			reset_count = 2'b00;
		end
		else begin
			case(reset_count)
				2'b00: begin
						reset_out = 1;
						reset_count = 2'b01;
				end
				2'b01: begin
						reset_out = 1;
						reset_count = 2'b10;
				end
				2'b10: begin
						reset_out = 1;
						reset_count = 2'b11;
				end
				2'b11: begin
						reset_out = 0;
				end
			endcase
		end
	end
endmodule
