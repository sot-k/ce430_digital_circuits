module FourDigitLEDdriver(reset, clk, an3, an2, an1, an0, a, b, c, d, e, f, g, dp);
input clk, reset;
output an3, an2, an1, an0;
output a, b, c, d, e, f, g, dp;

wire clk,reset;
wire CLK0,CLKDV;

reg an3, an2, an1, an0;
reg[3:0] ancounter,char;
wire[3:0] an3char, an2char, an1char, an0char;
wire a, b, c, d, e, f, g, dp;
wire[6:0] LED;

DCM #(
      .SIM_MODE("SAFE"),  // Simulation: "SAFE" vs. "FAST", see "Synthesis and Simulation Design Guide" for details
      .CLKDV_DIVIDE(16.0), // Divide by: 1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5
                          //   7.0,7.5,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0 or 16.0
      .CLKFX_DIVIDE(1),   // Can be any integer from 1 to 32
      .CLKFX_MULTIPLY(4), // Can be any integer from 2 to 32
      .CLKIN_DIVIDE_BY_2("FALSE"), // TRUE/FALSE to enable CLKIN divide by two feature
      .CLKIN_PERIOD(20.0),  // Specify period of input clock
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
      .RST(reset)        // DCM asynchronous reset input
   );


LEDdecoder mydecoder(char, LED);
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
	//for this part i have assign the 4 digits on our board on 0,1,2,3
	assign an3char = 4'b0000;
	assign an2char = 4'b0001;
	assign an1char = 4'b0010;
	assign an0char = 4'b0011;

	always@(posedge CLKDV or posedge reset) begin
		//here we are reseting our system
		if(reset) begin
			an3 = 1;
			an2 = 1;
			an1 = 1;
			an0 = 1;
		//we reset the 4bit-counter to 0000 so when our system starts working
//it will begin with loading the an3char which are the data we need to print on
//our first screen, the an3 screeen
			ancounter = 4'b0000;
		end
		else begin
/*the way this case works is like that:
		we keep the displays only 1 cycle open and we chose:
			an3 opens when the counter is 1110
			an2 opens when the counter is 1010
			an1 opens when the counter is 0110
			an0 opens when the counter is 0010

		on the next cycle we close the display
			an3 closes when the counter is 1101
			an2 closes when the counter is 1001
			an1 closes when the counter is 0101
			an0 closes when the counter is 0001

		then we keep all displays closed for 2 more cycles (3 in total)
		and then we open the next one

		in the meantime we should preload the data we want to print on the next
		display. this ha to be done 2 cycles before the display opens. this means that
			we preload an3char to char when the counter is 0000
			we preload an2char to char when the counter is 1010
			we preload an1char to char when the counter is 1000
			we preload an0char to char when the counter is 0100

		on the other possible values of the ancounter we dont want to do anything

		in the end we ancounter-- and if the counter has reached the value 4'b0000
		we just reset it on the value 4'b1111
*/
			case(ancounter)
				4'b1110 : an3 = 0;
				4'b1101 : an3 = 1;
				4'b1100 : char = an2char;
				4'b1010 : an2 = 0;
				4'b1001 : an2 = 1;
				4'b1000 : char = an1char;
				4'b0110 : an1 = 0;
				4'b0101 : an1 = 1;
				4'b0100 : char = an0char;
				4'b0010 : an0 = 0;
				4'b0001 : an0 = 1;
				4'b0000 : char = an3char;
				default: ;
			endcase
			if(ancounter == 4'b0000)
				ancounter = 4'b1111;
			else
				ancounter = ancounter - 1;
		end
	end
endmodule
