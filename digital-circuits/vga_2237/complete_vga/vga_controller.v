module vgacontroller(resetbutton, clk, VGA_RED, VGA_GREEN, VGA_BLUE, VGA_HSYNC, VGA_VSYNC);
	input resetbutton, clk;
	output VGA_RED, VGA_GREEN, VGA_BLUE, VGA_HSYNC, VGA_VSYNC;

	wire VGA_RED, VGA_GREEN, VGA_BLUE, VGA_HSYNC, VGA_VSYNC;
	reg async_reset;
	reg sync_reset;
	wire red_out, green_out, blue_out;
	wire[7:0]HPIXEL;
	wire[5:0]VPIXEL;
	wire[13:0]address;
	wire Hdeactivate;

 	mem mymem(.clk(clk), .reset(sync_reset), .address(address), .red_out(red_out),
			 .green_out(green_out), .blue_out(blue_out));

	Hsync myHsync(.reset(sync_reset), .clk(clk), .hpixel(HPIXEL), .hdeactivate(Hdeactivate),
				.VGA_HSYNC(VGA_HSYNC));

	Vsync myVsync(.reset(sync_reset), .clk(clk), .vpixel(VPIXEL), .vdeactivate(Vdeactivate),
	 			.VGA_VSYNC(VGA_VSYNC));
// sync flipflops for reset//
	always @ (posedge clk) begin
		async_reset = resetbutton;
	end

	always @ (posedge clk) begin
		sync_reset = async_reset;
	end

	assign address = {VPIXEL, HPIXEL};
// if vsync or hsync are deactivated pixels are all black
	assign VGA_RED = (Vdeactivate || Hdeactivate) ? 1'b0 : red_out;
	assign VGA_BLUE = (Vdeactivate || Hdeactivate) ? 1'b0 : blue_out;
	assign VGA_GREEN = (Vdeactivate || Hdeactivate) ? 1'b0 : green_out;

endmodule
