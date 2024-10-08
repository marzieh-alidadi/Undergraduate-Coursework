`timescale 1ns / 1ps

module add_TB;

	reg [31:0] in1;
	reg [31:0] in2;

	wire [31:0] out;

	add uut (
		.in1(in1), 
		.in2(in2), 
		.out(out)
	);

	initial begin

		in1 = 0;
		in2 = 0;

		#60;
      in1 = 1;
		in2 = 12;
		
		#60;
      in1 = 5;
		in2 = 42;
		
		#60;
      in1 = 0;
		in2 = 70;
		
		#60;
      in1 = 5;
		in2 = 100;

	end
      
endmodule

