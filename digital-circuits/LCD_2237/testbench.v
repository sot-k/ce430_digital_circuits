module testbench;

reg clk=0;
reg reset;
wire ready;
wire [3:0] SFD;
parameter CLK_HALF_PERIOD = 10;

	always begin
		#CLK_HALF_PERIOD clk = !clk;
	end


lcd_fsm mylcd_fsm(.clk(clk), .reset(reset), .LCDE(LCDE), .LCDRS(LCDRS), .LCDRW(LCDRW),
				.SFD_0(SFD_0), .SFD_1(SFD_1), .SFD_2(SFD_2), .SFD_3(SFD_3));


	initial begin

		reset = 1'b1;
		#200 reset = 1'b0;
	end

endmodule
