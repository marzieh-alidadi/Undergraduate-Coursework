`timescale 1ns / 1ps

module PC_TB;

	reg clk;
	reg [31:0] in;

	wire [31:0] out;

	PC uut (
		.clk(clk), 
		.in(in), 
		.out(out)
	);

	initial begin

		clk = 0;
		in = 0;

		#40;
      in = 222;
		
		#50;
      in = 111;
		
		#100;
      in = 0;
		
	end
	
	initial repeat (20) #20 clk = ~clk;
      
endmodule

