module testbench;

reg clk=0;
reg reset, ready;
reg[3:0] instruction;
reg[7:0] DB;
parameter CLK_HALF_PERIOD = 10;

	always begin
		#CLK_HALF_PERIOD clk = !clk;
	end


command_fsm mycommand_fsm(.clk(clk), .reset(reset), .ready(ready), .SF_D(SF_D),
							.DB(DB), .LCD_E(LCD_E), .LCD_RS(LCD_RS), .LCD_RW(LCD_RW),
							.instruction(instruction));


	initial begin

		reset = 1'b1;
		#200 reset = 1'b0;
		instruction = 4'b1011;
		DB = 8'b00101000;
		#20 ready = 1'b1;
		#400 ready = 1'b0;
		#50000 ready = 1'b1;
	end

endmodule
