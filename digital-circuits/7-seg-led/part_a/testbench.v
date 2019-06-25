`timescale 1ns/1ps

module testbench();

	reg [3:0] char;
	wire [6:0] LED;
	reg tb_clk;
	parameter CLK_HALF_PERIOD = 20;

	LEDdecoder mydecoder(char, LED);//poio prepei na einai to top level module? to tb i kapoio allo module?

	always begin
		#CLK_HALF_PERIOD tb_clk = !tb_clk;
	end
	
	initial begin
			
		#5 char = 4'b0000;
		#5 if(LED ==0000001) 
			$display("All good!");
		else 
			$display("ERROR!");

		#5  char = 4'b0110;
		#5 if(LED ==0100000) 
			$display("All good!");
		else 
			$display("ERROR!");

		#5 char = 4'b1000;
		#5 if(LED ==0000000) 
			$display("All good!");
		else 
			$display("ERROR!");
	
		#5 char = 4'b0100;
		#5 if(LED ==1001100)
			$display("All good!");
		else 
			$display("ERROR!");
	
		#5 char = 4'b0010;
		#5 if(LED ==0010010) 
			$display("All good!");
		else 
			$display("ERROR!");
	
		#5 char = 4'b0001;
		#5 if(LED ==1001111) 
			$display("All good!");
		else 
			$display("ERROR!");

		$finish;
	end
endmodule
