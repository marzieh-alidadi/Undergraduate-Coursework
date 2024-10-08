`timescale 1ns / 1ps

module instruction_memory_TB;

	reg clk;
	reg [4:0] address;

	wire [31:0] instruction;

	instruction_memory uut (
		.clk(clk), 
		.address(address), 
		.instruction(instruction)
	);

	initial begin

		clk = 0;
		address = 0;

		#60;
		address = 21;

		#60;
		address = 1;
		
		#60;
		address = 6;
		
		end
      
endmodule