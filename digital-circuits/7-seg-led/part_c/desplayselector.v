module desplaySelector (clk,reset,an3char,an2char,an1char,an0char,
				char,an3,an2,an1,an0);
	input clk,reset;
	input[3:0] an3char,an2char,an1char,an0char;

	output[3:0] char;
	output an3,an2,an1,an0;
	
	reg[3:0] char, ancounter;
	reg an3,an2,an1,an0;

	always@(posedge clk or posedge reset) begin
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