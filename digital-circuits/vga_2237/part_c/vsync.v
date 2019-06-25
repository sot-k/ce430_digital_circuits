module Vsync(reset, clk, vpixel, vdeactivate, VGA_VSYNC);
	input reset, clk;

	output vpixel, vdeactivate, VGA_VSYNC;

	parameter VDEACTIVATED = 1'b0;
	parameter VACTIVATED = 1'b1;

	parameter RGBBACKPORCH = 2'b00;
	parameter RGBACTIVATED = 2'b01;
	parameter RGBFRONTPORCH = 2'b10;
	reg Vstate, vdeactivate, VGA_VSYNC;
	reg[1:0] rgbstate;
	reg[19:0]vcounter, rgbcounter;
	reg[5:0]vpixel;
	reg[10:0]rowtiming;
	reg[3:0]pixelcounter;

	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			Vstate = VDEACTIVATED;
			vdeactivate = 1'b1;
			VGA_VSYNC = 1'b0;
			rgbstate = 2'b00;
			vpixel = 6'b000000;
			vcounter = 20'b00000000000000000000;
			rgbcounter = 20'b00000000000000000000;
			rowtiming = 11'b00000000000;
			pixelcounter = 4'b0000;
		end
		else begin

			case (Vstate)
				VDEACTIVATED: begin
					VGA_VSYNC = 1'b0;
					vdeactivate = 1'b1;
					if (vcounter == 20'b00000000110001111111) begin
						Vstate = VACTIVATED;
					end
					vcounter = vcounter + 1;
				end

				VACTIVATED: begin
					VGA_VSYNC = 1'b1;
					// i akribis timi tou einai 16,672ms
					if (vcounter == 20'b11001011100000111111) begin
						vcounter = 20'b00000000000000000000;
						Vstate = VDEACTIVATED;
					end
					else begin
						vcounter = vcounter + 1;
					end

					case (rgbstate)
						RGBBACKPORCH: begin
							vdeactivate = 1'b1;
							if (rgbcounter == 20'b00001011010100111111) begin
								rgbstate = RGBACTIVATED;
							end
							rgbcounter = rgbcounter + 1;
						end

						RGBACTIVATED: begin
							vdeactivate = 1'b0;
							if (rgbcounter == 20'b11000110110100111111) begin
								rgbstate = RGBFRONTPORCH;
							end
							rgbcounter = rgbcounter + 1;

							if (rowtiming == 11'b11000111111) begin
								rowtiming = 11'b00000000000;
								if (pixelcounter == 4'b1001) begin
					// an ftasei sto telos to ksanaarxikopoioume //
									if (vpixel == 6'b101111) begin
										vpixel = 6'b000000;
									end
									else begin
										vpixel = vpixel + 1;
									end
									pixelcounter = 4'b0000;
								end
								else begin
									pixelcounter = pixelcounter + 1;
								end
							end
							else begin
								rowtiming = rowtiming + 1;
							end
						end

						RGBFRONTPORCH: begin
							vdeactivate = 1'b1;
							if (rgbcounter == 20'b11001010101110111111) begin
								rgbstate = RGBBACKPORCH;
								rgbcounter = 20'b00000000000000000000;
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
