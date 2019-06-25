module mem(clk, reset, address, red_out, green_out, blue_out);
	input clk, reset;
	input[13:0] address;

	output red_out,green_out, blue_out;

	wire red_out,green_out, blue_out;

   RAMB16_S1 #(
      .INIT(1'b0),  // Value of output RAM registers at startup
      .SRVAL(1'b0), // Output value upon SSR assertion
      .WRITE_MODE("WRITE_FIRST"), // WRITE_FIRST, READ_FIRST or NO_CHANGE

      // The forllowing INIT_xx declarations specify the initial contents of the RAM
      // Address 0 to 4095
      .INIT_00(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_01(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_02(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_03(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_04(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_05(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_06(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_07(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_08(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_09(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_0A(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_0B(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_0E(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_0F(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      // Address 4096 to 8191
      .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_12(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_13(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_16(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_17(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_1A(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_1B(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_1E(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_1F(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      // Address 8192 to 12287
      .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_22(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_23(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
      .INIT_24(256'h00f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f0),
      .INIT_25(256'h00f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f0),
      .INIT_26(256'h00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff),
      .INIT_27(256'h00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff),
      .INIT_28(256'h00f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f0),
      .INIT_29(256'h00f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f0),
      .INIT_2A(256'h00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff),
      .INIT_2B(256'h00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff),
      .INIT_2C(256'h00f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f0),
      .INIT_2D(256'h00f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f0),
      .INIT_2E(256'h00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff),
      .INIT_2F(256'h00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff),
      // Address 12288 to 16383
      .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000)
   ) red_ram (
      .DO(red_out),      // 1-bit Data Output
      .ADDR(address),  // 14-bit Address Input
      .CLK(clk),    // Clock
      .DI(DI),      // 1-bit Data Input
      .EN(1'b1),      // RAM Enable Input
      .SSR(reset),    // Synchronous Set/Reset Input
      .WE(WE)       // Write Enable Input
   );

   RAMB16_S1 #(
	  .INIT(1'b0),  // Value of output RAM registers at startup
	  .SRVAL(1'b0), // Output value upon SSR assertion
	  .WRITE_MODE("WRITE_FIRST"), // WRITE_FIRST, READ_FIRST or NO_CHANGE

	  // The forllowing INIT_xx declarations specify the initial contents of the RAM
	  // Address 0 to 4095
	  .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_02(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_03(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_06(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_07(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_0A(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_0B(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_0C(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_0D(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_0E(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_0F(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  // Address 4096 to 8191
	  .INIT_10(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_11(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_12(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_13(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_14(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_15(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_16(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_17(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_1A(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_1B(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_1E(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_1F(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  // Address 8192 to 12287
	  .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_22(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_23(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_24(256'h0f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f00),
	  .INIT_25(256'h0f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f00),
	  .INIT_26(256'h0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f),
	  .INIT_27(256'h0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f),
	  .INIT_28(256'h0f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f00),
	  .INIT_29(256'h0f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f00),
	  .INIT_2A(256'h0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f),
	  .INIT_2B(256'h0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f),
	  .INIT_2C(256'h0f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f00),
	  .INIT_2D(256'h0f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f00),
	  .INIT_2E(256'h0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f),
	  .INIT_2F(256'h0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f),
	  // Address 12288 to 16383
	  .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000)
   ) green_ram (
	  .DO(green_out),      // 1-bit Data Output
	  .ADDR(address),  // 14-bit Address Input
	  .CLK(clk),    // Clock
	  .DI(DI),      // 1-bit Data Input
	  .EN(1'b1),      // RAM Enable Input
	  .SSR(reset),    // Synchronous Set/Reset Input
	  .WE(WE)       // Write Enable Input
   );

   RAMB16_S1 #(
	  .INIT(1'b0),  // Value of output RAM registers at startup
	  .SRVAL(1'b0), // Output value upon SSR assertion
	  .WRITE_MODE("WRITE_FIRST"), // WRITE_FIRST, READ_FIRST or NO_CHANGE

	  // The forllowing INIT_xx declarations specify the initial contents of the RAM
	  // Address 0 to 4095
	  .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_02(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_03(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_06(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_07(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_0A(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_0B(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_0E(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_0F(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  // Address 4096 to 8191
	  .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_12(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_13(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_16(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_17(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_18(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_19(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_1A(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_1B(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_1C(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_1D(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_1E(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_1F(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  // Address 8192 to 12287
	  .INIT_20(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_21(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_22(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_23(256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff),
	  .INIT_24(256'hf000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000),
	  .INIT_25(256'hf000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000),
	  .INIT_26(256'hf00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00f),
	  .INIT_27(256'hf00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00f),
	  .INIT_28(256'hf000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000),
	  .INIT_29(256'hf000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000),
	  .INIT_2A(256'hf00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00f),
	  .INIT_2B(256'hf00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00f),
	  .INIT_2C(256'hf000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000),
	  .INIT_2D(256'hf000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000),
	  .INIT_2E(256'hf00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00f),
	  .INIT_2F(256'hf00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00ff00f),
	  // Address 12288 to 16383
	  .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
	  .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000)
   ) blue_ram (
	  .DO(blue_out),      // 1-bit Data Output
	  .ADDR(address),  // 14-bit Address Input
	  .CLK(clk),    // Clock
	  .DI(DI),      // 1-bit Data Input
	  .EN(1'b1),      // RAM Enable Input
	  .SSR(reset),    // Synchronous Set/Reset Input
	  .WE(WE)       // Write Enable Input
   );

  // End of RAMB16_S1_inst instantiation
endmodule // mem
