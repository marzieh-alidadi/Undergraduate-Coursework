`timescale 1ns / 1ps

module mux_2to1_TB;

	reg [31:0] in1;
	reg [31:0] in2;
	reg select;

	wire [31:0] out;

	mux_2to1 uut (
		.in1(in1), 
		.in2(in2), 
		.select(select), 
		.out(out)
	);

	initial begin

		in1 = 0;
		in2 = 0;
		select = 0;

		#50;
      in1 = 452;
		in2 = 167;
		select = 0;
		
		#40;
      in1 = 252;
		in2 = 65;
		select = 1;

		#70;
      in1 = 2;
		in2 = 165;
		select = 1;
		
	end
      
endmodule

