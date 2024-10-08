`timescale 1ns / 1ps

module MIPS_top_module_TB;

	reg clk;
	wire[31:0] data1, data2;
	wire alu_zero;
	wire [31:0] alu_result;
	wire [31:0] mux4_out;

	MIPS_top_module uut (
		.clk(clk),
		.data1(data1),
		.data2(data2),
		.alu_zero(alu_zero),
		.alu_result(alu_result),
		.mux4_out(mux4_out)
	);

	initial begin

		clk = 0;
      
	end
	
	initial repeat (20) #20 clk = ~clk;
 
endmodule

