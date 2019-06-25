module messageSelector (clk,reset,an3char,an2char,an1char,an0char);

	output[3:0] an3char, an2char, an1char, an0char;
	input clk,reset;

	reg [3:0]an3char, an2char, an1char, an0char, counter;
	reg [3:0]message[0:15];
	//reg[4:0] timer;
	reg[21:0] timer;

//this module selects the 4 words of our 16-word message that should be desplayed
//whenever a reset signal comes the message is being initialised on the first 4 words
//and the counter is initialised on 0000


	always @ (posedge clk or posedge reset ) begin
		if (reset) begin
			message[0] = 4'b0000;
			message[1] = 4'b0001;
			message[2] = 4'b0010;
			message[3] = 4'b0011;
			message[4] = 4'b0100;
			message[5] = 4'b0101;
			message[6] = 4'b0110;
			message[7] = 4'b0111;
			message[8] = 4'b1000;
			message[9] = 4'b1001;
			message[10] = 4'b1010;
			message[11] = 4'b1011;
			message[12] = 4'b1100;
			message[13] = 4'b1101;
			message[14] = 4'b1110;
			message[15] = 4'b1111;
			counter = 4'b0000;

			//timer = 5'b00000;

			timer = 22'b0000000000000000000000;

			an3char = message[0];
			an2char = message[1];
			an1char = message[2];
			an0char = message[3];
		end
		/*
		if the button is pressed i move the counter to its next value and then
		i sellect which is the next message. for example if the current message
		was 0123, then the next message should be 1234, etc
		*/
		else begin
			if(timer == 22'b1111111111111111111111)begin
				if (counter == 4'b1111) begin
					counter = 4'b0000;
				end
				else begin
					counter = counter + 1;
				end

				case (counter)
					4'b0000:begin
							an3char = message[0];
							an2char = message[1];
							an1char = message[2];
							an0char = message[3];
					end
					4'b0001:begin
							an3char = message[1];
							an2char = message[2];
							an1char = message[3];
							an0char = message[4];
					end
					4'b0010:begin
							an3char = message[2];
							an2char = message[3];
							an1char = message[4];
							an0char = message[5];
					end
					4'b0011:begin
							an3char = message[3];
							an2char = message[4];
							an1char = message[5];
							an0char = message[6];
					end
					4'b0100:begin
							an3char = message[4];
							an2char = message[5];
							an1char = message[6];
							an0char = message[7];
					end
					4'b0101:begin
							an3char = message[5];
							an2char = message[6];
							an1char = message[7];
							an0char = message[8];
					end
					4'b0110:begin
							an3char = message[6];
							an2char = message[7];
							an1char = message[8];
							an0char = message[9];
					end
					4'b0111:begin
							an3char = message[7];
							an2char = message[8];
							an1char = message[9];
							an0char = message[10];
					end
					4'b1000:begin
							an3char = message[8];
							an2char = message[9];
							an1char = message[10];
							an0char = message[11];
					end
					4'b1001:begin
							an3char = message[9];
							an2char = message[10];
							an1char = message[11];
							an0char = message[12];
					end
					4'b1010:begin
							an3char = message[10];
							an2char = message[11];
							an1char = message[12];
							an0char = message[13];
					end
					4'b1011:begin
							an3char = message[11];
							an2char = message[12];
							an1char = message[13];
							an0char = message[14];
					end
					4'b1100:begin
							an3char = message[12];
							an2char = message[13];
							an1char = message[14];
							an0char = message[15];
					end
					4'b1101:begin
							an3char = message[13];
							an2char = message[14];
							an1char = message[15];
							an0char = message[0];
					end
					4'b1110:begin
							an3char = message[14];
							an2char = message[15];
							an1char = message[0];
							an0char = message[1];
					end
					4'b1111:begin
							an3char = message[15];
							an2char = message[0];
							an1char = message[1];
							an0char = message[2];
					end
				endcase
				//timer = 5'b00000;
				timer = 22'b0000000000000000000000;
			end
			else begin
				timer = timer + 1;
			end
		end
	end

endmodule // messageSelector
