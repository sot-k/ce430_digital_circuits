 module resetsync(clk, reset, reset_sync);
	input wire clk,reset;
	output reg reset_sync;
	
	reg async_reset;
	
	always @(posedge clk) begin
		async_reset = reset;
	end
	
	always @(posedge clk) begin
		reset_sync = async_reset;
	end

endmodule