/*This is a command fsm for my project on spartan3e lcd display.
	The module recieves an instruction number along with the DB bits that are
	to be transmited through SF_D and a ready signal that means the machine
	is ready to begin the transmition. After that it begins the transmiting
	process with this sequence:

	transmiting the first 4 bits
			|
			v
	wait for 1us
			|
			v
	trasmit the second 4 bits
			|
			v
	wait for 40 us
			|
			v
	ready to take the next command

	it also manages the signals LCD_E, LCD_RS and LCD_RW acordingly.
*/
module command_fsm(clk, reset, ready, SF_D, DB, LCD_E, LCD_RS, LCD_RW, instruction);

	input clk, reset, ready;
	input [7:0] DB;
	input [3:0] instruction;

	output LCD_E, LCD_RS, LCD_RW;
	output [3:0] SF_D;

	reg LCD_E, LCD_RS, LCD_RW;
	reg[3:0] SF_D;

	reg[11:0] counter;
	reg[2:0] current_state, next_state;


	parameter IDLE = 3'b000;
	parameter FIRSTPART = 3'b001;
	parameter BETWEENPARTS = 3'b010;
	parameter SECONDPART = 3'b011;
	parameter ENDWAIT = 3'b100;

	parameter MAX = 2080;



	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			current_state = IDLE;
			// next_state = IDLE;
			counter = 0;
		end
		else begin
			if (counter == MAX) begin
				counter = 0;
			end
			if (ready && current_state == IDLE) begin
				// next_state = FIRSTPART;
				current_state = FIRSTPART;
				counter = 0;
			end
			else begin
				current_state = next_state;
				counter = counter + 1;
			end
		end
	end

	always @(ready or DB or instruction or current_state or counter) begin
		next_state = current_state;
		case (current_state)

			IDLE: begin
				LCD_E = 1'b0;
				LCD_RS = 1'b0;
				LCD_RW = 1'b0;
				SF_D = DB[7:4];
				// counter = 1'b0;
			end

			FIRSTPART: begin
				//initialising

				SF_D = DB[7:4];
				case (counter)
					//40ns waiting after initialisation
					0,1: begin
						LCD_E = 1'b0;
					end
					//240ns of leaving LCD_E open
					2,3,4,5,6,7,8,9,10,11,12,13: begin
						LCD_E = 1'b1;

					end

					14: begin
						LCD_E = 1'b0;
					end

					//20ns waiting after we close LCD_E
					15: begin
						next_state = BETWEENPARTS;
						LCD_E = 1'b0;
					end
					default: begin
						LCD_E = 1'bx;
					end
				endcase

				case (instruction)
				//Read Data from CGRAM/DDRAM
					4'b1011: begin
						LCD_RS = 1'b1;
						LCD_RW = 1'b1;
					end
					//Write Data to CGRAM/DDRAM
					4'b1010: begin
						LCD_RS = 1'b1;
						LCD_RW = 1'b0;
					end
					//Ready Busy Flag and Address
					4'b1001: begin
						LCD_RS = 1'b0;
						LCD_RW = 1'b1;
					end

					default: begin
						LCD_RS = 1'b0;
						LCD_RW = 1'b0;
					end
				endcase


			end

			BETWEENPARTS: begin
				LCD_E = 1'b0;
				LCD_RS = 1'b0;
				LCD_RW = 1'b0;
				SF_D = DB[3:0];
				//50 cycles waiting between the parts (1us)
				if (counter == 65) begin
					next_state = SECONDPART;
				end
				// counter = counter + 1;
			end

			SECONDPART: begin

				SF_D = DB[3:0];
				case (counter)
					66,67: begin
						LCD_E = 1'b0;
					end

					68,69,70,71,72,73,74,75,76,77,78,79: begin
						LCD_E = 1'b1;

					end

					80: begin
						LCD_E = 1'b0;
					end

					81: begin
						next_state = ENDWAIT;
						LCD_E = 1'b0;
					end
					default: begin
						LCD_E = 1'bx;
					end
				endcase

				case (instruction)
					4'b1011: begin
						LCD_RS = 1'b1;
						LCD_RW = 1'b1;
					end

					4'b1010: begin
						LCD_RS = 1'b1;
						LCD_RW = 1'b0;
					end

					4'b1001: begin
						LCD_RS = 1'b0;
						LCD_RW = 1'b1;
					end

					default: begin
						LCD_RS = 1'b0;
						LCD_RW = 1'b0;
					end
				endcase

			end

			ENDWAIT: begin
				LCD_E = 1'b0;
				LCD_RS = 1'b0;
				LCD_RW = 1'b0;
				SF_D = 4'b0000;
				//waiting for 40us (2000 cycles)
				if (counter == MAX) begin
					next_state = IDLE;
				end
				// counter = counter + 1;
			end

			default: begin
				SF_D = 4'bxxxx;
				LCD_E = 1'bx;
				LCD_RS = 1'bx;
				LCD_RW = 1'bx;
			end
		endcase

	end



endmodule
