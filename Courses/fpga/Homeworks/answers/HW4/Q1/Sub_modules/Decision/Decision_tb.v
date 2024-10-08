`timescale 1ns / 1ps

module Decision_tb;

	reg [1:0] correct_guess;
	reg [1:0] out_wr;
	reg clk;

	wire [1:0] result;

	Decision uut (
		.correct_guess(correct_guess), 
		.out_wr(out_wr), 
		.clk(clk), 
		.result(result)
	);

	initial begin
		correct_guess = 0;
		out_wr = 0;
		clk = 0;
		
		#20
		correct_guess=2'b10;
		out_wr=2'b10;
		
		#40
		correct_guess=2'b00;
		out_wr=2'b11;
		
		#40
		correct_guess=2'b11;
		out_wr=2'b01;
		
		#40
		correct_guess=2'b01;
		out_wr=2'b11;
		
		#40
		correct_guess=2'b11;
		out_wr=2'b10;
		
		#40
		correct_guess=2'b00;
		out_wr=2'b01;
	end
	
	initial repeat (20) #20 clk = ~clk;
      
endmodule

