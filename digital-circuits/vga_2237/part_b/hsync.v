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
		// arxika xwrizoume ti leitourgeia tou sistimatos se 2 megales katigories //
		// an einai apenergopoieimeno to hsync (3,84 us) kai an einai apenergopoieimeno
		// (28,16 us) kai i diadikasia epanalambanetai kathe 32 us
			case (Hstate)
			//apenergopoieimeno gia ta prwta 3.84 us
				HDEACTIVATED: begin
					VGA_HSYNC = 1'b0;
					hdeactivate = 1'b1;
					if (hcounter == 11'b00010111111) begin
						Hstate = HACTIVATED;
					end
					hcounter = hcounter + 1;
				end
//ergopoieimeno apo 3,84 mexri 32 us
				HACTIVATED: begin
					VGA_HSYNC = 1'b1;
					if (hcounter == 11'b11000111111) begin
						hcounter = 11'b00000000000;
						Hstate = HDEACTIVATED;
					end
					else begin
						hcounter = hcounter + 1;
					end
// an to hsync einai energopoieimeno tote iparxoune 3 pithanes katastaseis:
// 		1) na exei molis energopoieithei kai na eimaste stin katastasi back porch
//		2) na eimaste stin katastasi desplay
//		3) na eimaste meta tin proboli mias plirous grammis stin katastasi front porch

// stin katastasi backporch h othoni den probalei kati gia 1.92 us (0-1.92 us)
					case (rgbstate)
						RGBBACKPORCH: begin
							hdeactivate = 1'b1;
							if (rgbcounter == 11'b00001011111) begin
								rgbstate = RGBACTIVATED;
							end
							rgbcounter = rgbcounter + 1;
						end
// se autin tin katastasi i othoni probalei seiriaka ta bits. i katastasi diarkei
// gia 25.6 us (1.92-27,52 us). auti einai i moni katastasi stin opoia to hdeactivate einai 0
						RGBACTIVATED: begin
							hdeactivate = 1'b0;
							if (rgbcounter == 11'b10101011111) begin
								rgbstate = RGBFRONTPORCH;
							end
							rgbcounter = rgbcounter + 1;
							/*
kathe 10 kiklous (apo 0 mexri 9) metakinoumaste sto epomeno pixel. auto ginetai
kathe 10 kiklous kathws	theloume logo tis xrisis simpiknomenis vram na xrisimopoi
eisoume 1 bit gia 5 kai episeis kathe bit prepei na meinei anoixto gia 2 kiklous
ara 5*2 = 10 kikloi.
							*/
							if (pixelcounter == 4'b1001) begin
				// an ftasei sto telos to ksanaarxikopoioume //
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
// stin katastasi front porch i othoni den probalei kati gia 0.64 us (27,52-28.16 us)
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
