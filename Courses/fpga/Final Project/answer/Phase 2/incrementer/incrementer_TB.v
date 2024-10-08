`timescale 1ns / 1ps

module incrementer_TB;

	reg [31:0] in;

	wire [31:0] in_plus;

	incrementer uut (
		.in(in), 
		.in_plus(in_plus)
	);

	initial begin

		in = 0;

		#10;
		in = 52;
		
		#50;
		in = 68;
		
		#40;
		in = 6;
		
		#35;
		in = 0;
		
	end
      
endmodule

