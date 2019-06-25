module FourDigitLEDdriver(button, reset, clk, an3, an2, an1, an0, a, b, c, d, e, f, g, dp);
	input clk, reset,button;
	output an3, an2, an1, an0;
	output a, b, c, d, e, f, g, dp;

	wire clk,reset;

	wire an3, an2, an1, an0;
	wire[3:0] char;
	wire[3:0] an3char, an2char, an1char, an0char;
	wire a, b, c, d, e, f, g, dp,button,reset_sync,reset_out;
	wire[6:0] LED;
	wire CLK0,CLKDV,antibounced_btn;

	DCM #(
	      .SIM_MODE("SAFE"),  // Simulation: "SAFE" vs. "FAST", see "Synthesis and Simulation Design Guide" for details
	      .CLKDV_DIVIDE(16.0), // Divide by: 1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5
	                          //   7.0,7.5,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0 or 16.0
	      .CLKFX_DIVIDE(1),   // Can be any integer from 1 to 32
	      .CLKFX_MULTIPLY(4), // Can be any integer from 2 to 32
	      .CLKIN_DIVIDE_BY_2("FALSE"), // TRUE/FALSE to enable CLKIN divide by two feature
	      .CLKIN_PERIOD(0.0),  // Specify period of input clock
	      .CLKOUT_PHASE_SHIFT("NONE"), // Specify phase shift of NONE, FIXED or VARIABLE
	      .CLK_FEEDBACK("1X"),  // Specify clock feedback of NONE, 1X or 2X
	      .DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), // SOURCE_SYNCHRONOUS, SYSTEM_SYNCHRONOUS or
	                                            //   an integer from 0 to 15
	      .DFS_FREQUENCY_MODE("LOW"),  // HIGH or LOW frequency mode for frequency synthesis
	      .DLL_FREQUENCY_MODE("LOW"),  // HIGH or LOW frequency mode for DLL
	      .DUTY_CYCLE_CORRECTION("TRUE"), // Duty cycle correction, TRUE or FALSE
	      .FACTORY_JF(16'hC080),   // FACTORY JF values
	      .PHASE_SHIFT(0),     // Amount of fixed phase shift from -255 to 255
	      .STARTUP_WAIT("FALSE")   // Delay configuration DONE until DCM LOCK, TRUE/FALSE
	   ) DCM_inst (
	      .CLK0(CLK0),     // 0 degree DCM CLK output
	      .CLK180(CLK180), // 180 degree DCM CLK output
	      .CLK270(CLK270), // 270 degree DCM CLK output
	      .CLK2X(CLK2X),   // 2X DCM CLK output
	      .CLK2X180(CLK2X180), // 2X, 180 degree DCM CLK out
	      .CLK90(CLK90),   // 90 degree DCM CLK output
	      .CLKDV(CLKDV),   // Divided DCM CLK out (CLKDV_DIVIDE)
	      .CLKFX(CLKFX),   // DCM CLK synthesis out (M/D)
	      .CLKFX180(CLKFX180), // 180 degree CLK synthesis out
	      .LOCKED(LOCKED), // DCM LOCK status output
	      .PSDONE(PSDONE), // Dynamic phase adjust done output
	      .STATUS(STATUS), // 8-bit DCM status bits output
	      .CLKFB(CLK0),   // DCM clock feedback
	      .CLKIN(clk),   // Clock input (from IBUFG, BUFG or DCM)
	      .PSCLK(PSCLK),   // Dynamic phase adjust clock input
	      .PSEN(PSEN),     // Dynamic phase adjust enable input
	      .PSINCDEC(PSINCDEC), // Dynamic phase adjust increment/decrement
	      .RST(reset_out)        // DCM asynchronous reset input
	   );

	antiBounce myantiBounce(.clk(CLKDV), .n_reset(reset_out), .button_in(button),
				.DB_out(antibounced_btn));

	resetsync myresetsync(.clk(clk), .reset(reset), .reset_sync(reset_sync));

	resetmanager myresetmanager(.clk(clk), .reset(reset_sync), .reset_out(reset_out));

	LEDdecoder mydecoder(.char(char), .LED(LED));
	
	messageSelector myMSGselector(.button(antibounced_btn),.reset(reset_out),
			.an3char(an3char),.an2char(an2char),.an1char(an1char),.an0char(an0char));
			
	desplaySelector myDISPselector(.clk(CLKDV), .reset(reset_out),.an3char(an3char),
			.an2char(an2char),.an1char(an1char),.an0char(an0char),.char(char),.an3(an3),
			.an2(an2),.an1(an1),.an0(an0));

//we split the 7bit LED wire into 7 different wires
	assign a = LED[6];
	assign b = LED[5];
	assign c = LED[4];
	assign d = LED[3];
	assign e = LED[2];
	assign f = LED[1];
	assign g = LED[0];
	//we dont realy need dp so we assign it to 1
	assign dp = 1'b1;
	
	
endmodule
