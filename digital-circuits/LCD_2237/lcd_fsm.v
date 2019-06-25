module lcd_fsm(clk, reset, LCDE, LCDRS, LCDRW, SFD_0, SFD_1, SFD_2, SFD_3);

	input clk, reset;

	output LCDE, LCDRS, LCDRW;
	output SFD_0, SFD_1, SFD_2, SFD_3;

	wire SFD_0, SFD_1, SFD_2, SFD_3;
	wire LCDE, LCDRS, LCDRW;
	wire [3:0] SFD;
	wire [7:0] mem;
	wire [3:0] SF_D;

	reg [19:0] counter;
	reg [25:0] sec_counter;
	reg [1:0] current_state, next_state;
	reg init, lcd_e, sync_reset, async_reset, ready, refresh;
	reg [3:0] sf_d, command;
	reg [7:0] DB;
	reg [10:0] mem_addr;
	reg [11:0] cycle_counter;
	reg [5:0] command_counter;
	wire[10:0] new_mem_addr;
	wire[7:0] new_DB;
	wire[3:0] new_command;
	wire[5:0] new_command_counter;

	parameter MAX = 964048;
	parameter SEC = 50331648;
	parameter INITIALISATION = 2'b00;
	parameter CONFIGURATION = 2'b01;
	parameter LOOP = 2'b10;
	parameter COMPLETE_COMMAND = 2081;

	assign new_mem_addr = mem_addr;
	assign new_DB = DB;
	assign new_command = command;
	assign new_command_counter = command_counter;
	assign SFD_0 = SFD[0];
	assign SFD_1 = SFD[1];
	assign SFD_2 = SFD[2];
	assign SFD_3 = SFD[3];

	BRAM myBRAM(.clk(clk), .reset(sync_reset), .address(mem_addr), .out(mem));

	command_fsm mycommand_fsm(.clk(clk), .reset(sync_reset), .ready(ready), .SF_D(SF_D), .DB(DB),
	 					.LCD_E(LCD_E), .LCD_RS(LCDRS), .LCD_RW(LCDRW), .instruction(command));

	always @ (posedge clk) begin
		async_reset = reset;
	end

	always @ (posedge clk) begin
		sync_reset = async_reset;
	end

	always @ (posedge clk or posedge sync_reset) begin
		if (sync_reset) begin
			current_state = INITIALISATION;
			counter = 0;
		end
		else begin
			if (counter == MAX) begin
				counter = 0;
			end
			else begin
				counter = counter + 1;
			end
			current_state = next_state;
		end
	end


	always @ (posedge clk) begin
		next_state = current_state;

		case (current_state)

			INITIALISATION: begin
				init = 1'b1;
				refresh = 1'b0;
				sec_counter = 0;
				mem_addr = 0;
				cycle_counter = 0;
				DB = 0;
				command = 0;
				ready = 1'b0;
				command_counter = 0;
				if (counter >= 964048) begin
				// we wait for 2000 and we pass on the next state
					next_state = CONFIGURATION;
					lcd_e = 1'b0;
					sf_d = 4'h0;
				end else if (counter >= 962048) begin
				//we leave lcd_e up for 12 cycles
					lcd_e = 1'b0;
					sf_d = 4'h2;
				end else if (counter >= 962036) begin
					lcd_e = 1'b1;
					sf_d = 4'h2;
				end else if (counter >= 962034) begin
				// we wait for 2000 cycles
					sf_d = 4'h2;
					lcd_e = 1'b0;
				end else if (counter >= 960036) begin
				//we leave lcd_e up for 12 cycles
					lcd_e = 1'b0;
					sf_d = 4'h3;
				end else if (counter >= 960024) begin
				// we wait for 5000 cycles
					lcd_e = 1'b1;
					sf_d = 4'h3;
				end else if (counter >= 955024) begin
				//we leave lcd_e up for 12 cycles
					lcd_e = 1'b0;
					sf_d = 4'h3;
				end else if (counter >= 955012) begin
				//we wait for 205000 cycles
					lcd_e = 1'b1;
					sf_d = 4'h3;
				end else if (counter >= 750012) begin
				//we leave lcd_e up for 12 cycles
					lcd_e = 1'b0;
					sf_d = 4'h3;
				end else if (counter >= 750000) begin
					lcd_e = 1'b1;
					sf_d = 4'h3;
				end else if (counter >= 749998) begin
				//we wait for 15ms
					sf_d = 4'h3;
					lcd_e = 1'b0;
				end else begin
					sf_d = 4'h0;
					lcd_e = 1'b0;
				end
			end

			CONFIGURATION: begin
				lcd_e = 1'b0;
				sf_d = 4'h0;
				init = 1'b0;
				sec_counter = 0;
				mem_addr = 0;
				refresh = 1'b0;
				cycle_counter = 0;
				command_counter = 0;
				if (counter >= 88249) begin
					next_state = LOOP;
					ready = 1'b0;
					DB = 8'h01;
					command = 4'b0001;
				end else if (counter >= 6248) begin
					ready = 1'b0;
					DB = 8'h01;
					command = 4'b0001;
				end else if (counter >= 6246) begin
					DB = 8'h01;
					command = 4'b0001;
					ready = 1'b1;
				end else if (counter >= 4166) begin
					ready = 1'b0;
					DB = 8'h0C;
					command = 4'b0100;
				end else if (counter >= 4164) begin
					DB = 8'h0C;
					command = 4'b0100;
					ready = 1'b1;
				end else if (counter >= 2084) begin
					ready = 1'b0;
					DB = 8'h06;
					command = 4'b0011;
				end else if (counter >= 2082) begin
					DB = 8'h06;
					command = 4'b0011;
					ready = 1'b1;
				end else if (counter >= 2) begin
					ready = 1'b0;
					DB = 8'h28;
					command = 4'b0110;
				end else begin
					DB = 8'h28;
					command = 4'b0110;
					ready = 1'b1;
				end
			end

			LOOP: begin
				init = 1'b0;
				lcd_e = 1'b0;
				sf_d = 4'h0;
				if (sec_counter[25:24] == 2'b11) begin
					command_counter = new_command_counter;
					if (cycle_counter == COMPLETE_COMMAND) begin
						if (command_counter == 34) begin
							sec_counter = 0;
						end else begin
							sec_counter = SEC;
						end
						case (command_counter)
							0: begin
								DB = 8'b10000000;
								command = 4'b1000;
								ready = 1'b1;
								refresh = 1'b1;
								if (mem_addr >= 128) begin
									mem_addr = 0;
								end else begin
									mem_addr = new_mem_addr;
								end
							end
							1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16: begin
								DB = mem;
								refresh = 1'b1;
								command = 4'b1010;
								ready = 1'b1;
								mem_addr = mem_addr + 1;
							end
							17: begin
								refresh = 1'b1;
								DB = 8'b10101000;
								command = 4'b1000;
								ready = 1'b1;
								mem_addr = new_mem_addr;
							end
							18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33: begin
								DB = mem;
								refresh = 1'b1;
								command = 4'b1010;
								ready = 1'b1;
								mem_addr = mem_addr + 1;
							end

							34: begin
								DB = 0;
								refresh = 1'b0;
								command = 4'b0000;
								ready = 1'b0;
								mem_addr = new_mem_addr;
							end

							default: begin
								DB = 8'bxxxxxxxx;
								command = 4'bxxxx;
								ready = 1'bx;
								refresh = 1'bx;
								mem_addr = 11'bxxxxxxxxxxx;
							end
						endcase
						cycle_counter = 0;
						command_counter = command_counter + 1;
					end else begin
						cycle_counter = cycle_counter + 1;
						mem_addr = new_mem_addr;
						DB = new_DB;
						refresh = 1'b1;
						command = new_command;
						sec_counter = SEC;
						command_counter = new_command_counter;
					end
				end else begin
					refresh = 1'b0;
					ready = 1'b0;
					DB = new_DB;
					cycle_counter = 0;
					command = new_command;
					command_counter = 0;
					sec_counter = sec_counter + 1;
					mem_addr = new_mem_addr;
				end
			end

			default: begin
				init = 1'bx;
				refresh = 1'bx;
				command_counter = 6'bxxxxxx;
				cycle_counter = 12'bxxxxxxxxxxxx;
				sec_counter = 26'bxxxxxxxxxxxxxxxxxxxxxxxxxx;
				lcd_e = 1'bx;
				sf_d = 4'bxxxx;
				mem_addr = 11'bxxxxxxxxxxx;
				DB = 8'bxxxxxxxx;
				command = 4'bxxxx;
				ready = 1'bx;
			end

		endcase
	end

	assign LCDE = (init) ? lcd_e : LCD_E;
	assign SFD = (init) ? sf_d : SF_D;

endmodule
