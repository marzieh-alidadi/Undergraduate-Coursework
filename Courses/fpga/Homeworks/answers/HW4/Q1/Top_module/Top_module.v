`timescale 1ns / 1ps

module Top_module #(parameter N=8)(input [N-1:0] target_num, first_num, second_num,
				input clk, input reset, output [1:0] result, output [1:0] out_wr, output [1:0] correct_guess, output newClk);
	
	Correlation #(4) uut1 (
		.target_num(target_num), 
		.first_num(first_num), 
		.second_num(second_num), 
		.clk(clk),
		.reset(reset),
		.out_cr(out_cr), 
		.correct_guess(correct_guess)
	);
		
	Frequency_division uut2 (
		.clk(clk), 
		.reset(reset), 
		.newClk(newClk)
	);
	
	Winner uut3 (
		.out_cr(out_cr), 
		.newClk(newClk),
		.out_wr(out_wr)
	);
	
	Decision uut4 (
		.correct_guess(correct_guess), 
		.out_wr(out_wr), 
		.clk(clk), 
		.result(result)
	);

endmodule
