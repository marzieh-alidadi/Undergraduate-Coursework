`timescale 1ns / 1ps

module Top_module_tb;

	reg [7:0] target_num;
	reg [7:0] first_num;
	reg [7:0] second_num;
	reg clk;
	reg reset;

	wire [1:0] result;
	wire [1:0] out_wr;
	wire [1:0] correct_guess;
	wire newClk;

	Top_module uut (
		.target_num(target_num), 
		.first_num(first_num), 
		.second_num(second_num), 
		.clk(clk), 
		.reset(reset), 
		.result(result),
		.out_wr(out_wr),
		.correct_guess(correct_guess),
		.newClk(newClk)
	);

	initial begin
		target_num = 4'b1001;
		first_num = 0;
		second_num = 0;
		clk = 0;
		reset=0;
		
		#20 first_num= 4'b1001;
		second_num = 4'b0011;
		
		#40 first_num= 4'b0011;
		second_num = 4'b1001;
		
		#25 reset=1;
		
		#25 reset=0;
		
		#40 first_num= 4'b0011;
		second_num = 4'b1001;
		
		#40 first_num = 4'b1111;
		second_num = 4'b1111;
		
		#40 first_num = 4'b0110;
		second_num = 4'b0110;
		
		#40 first_num= 4'b0011;
		second_num = 4'b1001;
		
		#25 reset=1;
		
		#50 reset=0;

		#40 first_num = 4'b1111;
		second_num = 4'b1111;
		
		#40 first_num = 4'b0110;
		second_num = 4'b0110;
		
		#40 first_num= 4'b0011;
		second_num = 4'b1001;
		
		#40 first_num = 4'b1111;
		second_num = 4'b1111;
		
		#40 first_num = 4'b0110;
		second_num = 4'b0110;
		
	end
   
	initial repeat (50) #20 clk = ~clk;
      
endmodule

