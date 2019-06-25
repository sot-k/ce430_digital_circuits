module Hsync(reset, clk, hpixel, hdeactivate, VGA_HSYNC);
	input reset, clk;

	output hpixel, hdeactivate, VGA_HSYNC;

	parameter HDEACTIVATED = 1'b0;
	parameter HACTIVATED = 1'b1;

	parameter RGBBACKPORCH = 2'b00;
	parameter RGBACTIVATED = 2'b01;
	parameter RGBFRONTPORCH = 2'b10;
	reg Hstate, hdeactivate, VGA_HSYNC;
	reg[1:0] rgbstate;
	reg[10:0]hcounter, rgbcounter;
	reg[7:0]hpixel;
	reg[3:0]pixelcounter;

	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			hpixel = 1'b0;
			hdeactivate = 1'b1;
			VGA_HSYNC = 1'b0;
			Hstate = HDEACTIVATED;
			rgbstate = RGBBACKPORCH;
			hcounter = 11'b00000000000;
			rgbcounter = 11'b00000000000;
			hpixel = 8'b00000000;
			pixelcounter = 4'b0000;
		end
		else begin
		// initially we split the function of our system in 2 big states //
		//when hsync is deactivated (3,84 us) and when it is activated
		// (28,16 us) and this process is repeated every 32 us
			case (Hstate)
			//activated for the first 3.84 us or for the first 192 cycles
				HDEACTIVATED: begin
					VGA_HSYNC = 1'b0;
					hdeactivate = 1'b1;
					if (hcounter == 11'b00010111111) begin
						Hstate = HACTIVATED;
					end
					hcounter = hcounter + 1;
				end
//activated from 3,84 until 32 us or until 1599th cycle
				HACTIVATED: begin
					VGA_HSYNC = 1'b1;
					if (hcounter == 11'b11000111111) begin
						hcounter = 11'b00000000000;
						Hstate = HDEACTIVATED;
					end
					else begin
						hcounter = hcounter + 1;
					end
// if hsync is activated then there are 3 possible substates:
// 		1) it is just been activated so we are on back porch state
//		2) we are on desplay state
//		3) we desplayed a full line so we are on the front porch state

// on the back porch state vga is iddle for 1.92 us (0-1.92 us) or 96 cycles
					case (rgbstate)
						RGBBACKPORCH: begin
							hdeactivate = 1'b1;
							if (rgbcounter == 11'b00001011111) begin
								rgbstate = RGBACTIVATED;
							end
							rgbcounter = rgbcounter + 1;
						end
// in the desplay state the bits are being read in order. this state lasts for
// 25.6 us (1.92-27,52 us) or until the 1375th cycle.
						RGBACTIVATED: begin
							hdeactivate = 1'b0;
							if (rgbcounter == 11'b10101011111) begin
								rgbstate = RGBFRONTPORCH;
							end
							rgbcounter = rgbcounter + 1;
							/*
every 10 cycles (from 0 untill 9) we move to the next pixel. this happens every
10 cycles cause we want to unfold the compact vram we use in a bigger one which meens
1 bit should be used 5 times.also every bit should be activated for 2 cycles
so 5*2 = 10 cycles.
							*/
							if (pixelcounter == 4'b1001) begin
				// if we hit last bit we start from the beginning //
								if (hpixel == 8'b11111111) begin
									hpixel = 8'b00000000;
								end
								else begin
									hpixel = hpixel + 1;
								end
								pixelcounter = 4'b0000;
							end
							else begin
								pixelcounter = pixelcounter + 1;
							end
						end
// on front porch state vga is iddle for 0.64 us (27,52-28.16 us) or until 1407th cycle
						RGBFRONTPORCH: begin
							hdeactivate = 1'b1;
							if (rgbcounter == 11'b10101111111) begin
								rgbcounter = 11'b00000000000;
								rgbstate = RGBBACKPORCH;
							end
							else begin
								rgbcounter = rgbcounter + 1;
							end
						end
					endcase
				end
			endcase

		end

	end


endmodule
