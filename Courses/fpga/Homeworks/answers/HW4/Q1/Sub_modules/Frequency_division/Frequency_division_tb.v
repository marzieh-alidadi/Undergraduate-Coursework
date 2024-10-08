`timescale 1ns / 1ps

module Frequency_division_tb;

	reg clk;
	reg reset;

	wire newClk;

	Frequency_division uut (
		.clk(clk), 
		.reset(reset), 
		.newClk(newClk)
	);

	initial begin
		clk = 0;
		reset = 0;
		
		#225
		reset=1;
		
		#90
		reset=0;
		
		#100
		reset=1;
		
		#100
		reset=0;

	end
	
	initial repeat (100) #20 clk = ~clk;
      
endmodule

