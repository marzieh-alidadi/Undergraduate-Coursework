`timescale 1ns / 1ps

module sign_extend_TB;

	reg clk;
	reg [15:0] in;

	wire [31:0] in_extend;

	sign_extend uut (
		.clk(clk), 
		.in(in), 
		.in_extend(in_extend)
	);

	initial begin

		clk = 0;
		in = 0;

		#60;
      in = 16'b1010101010101010;

		#60;
      in = 16'b0010101010101010;
		
		#60;
      in = 16'b0101010;
		
		#60;
      in = 16'b10101010;

	end

	initial repeat (30) #20 clk = ~clk;

endmodule

