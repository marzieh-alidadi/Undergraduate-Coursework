`timescale 1ns / 1ps

module Decision(input [1:0] correct_guess, out_wr, input clk,
					 output reg [1:0] result);
	
	always @(posedge clk) begin
		if(correct_guess==00)
			result<=out_wr;
		else
			result<=correct_guess;
	end
	
endmodule
