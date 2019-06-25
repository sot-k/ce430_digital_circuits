module  antiBounce(clk, n_reset, button_in, DB_out);
	parameter N = 19 ;

	input clk, n_reset, button_in;
	output reg 	DB_out;

	reg  [N-1 : 0]	q_reg;							// timing regs
	reg  [N-1 : 0]	q_next;
	reg DFF1, DFF2;									// input flip-flops
	wire q_add;											// control flags
	wire q_reset;

////contenious assignment for counter control
	assign q_reset = (DFF1  ^ DFF2);		// xor input flip flops to look for level change to reset counter
	assign  q_add = ~(q_reg[N-1]);			// add to counter when q_reg msb is equal to 0

/*how this always works:
		if DFF1 ^ DFF2 = 1 then our button has changed values thus we have to
		reinitialize the counter.

		if the xor result is 0 then that means our button hasnt changed values.
		so then we check the most significant bit of our timing reg.
		if the most significant bit is 1 then we have reached the maximum
		ammount of clock cycles and we just reassign the value to the reg.
		else we havent yet decided if the button is steady enough so we keep going,
		addin +1 for every cycle it remains steady.
*/
	always @ ( q_reset, q_add, q_reg)
		begin
			case( {q_reset , q_add})
				2'b00 :
						q_next <= q_reg;
				2'b01 :
						q_next <= q_reg + 1;
				default :
						q_next <= { N {1'b0} };
			endcase
		end

// Flip flop inputs and q_reg update //
	always @ ( posedge clk )
		begin//if reset then we reset the counter//
			if(n_reset ==  1'b1)
				begin
					DFF1 <= 1'b0;
					DFF2 <= 1'b0;
					q_reg <= { N {1'b0} };
				end
			else
				begin//else we update the values of our ffs//
					DFF1 <= button_in;
					DFF2 <= DFF1;
					q_reg <= q_next;
				end
		end

// counter control //
// If the time has passed and our counter has reached //
// its maximum value, then its time to update its value. //
// else keep the old one. //
	always @ ( posedge clk )
		begin
			if(q_reg[N-1] == 1'b1)// this means that we count up to (2^18) + 1 //
					DB_out <= DFF2;
			else
					DB_out <= DB_out;
		end

endmodule
