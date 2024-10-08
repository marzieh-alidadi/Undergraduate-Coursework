`timescale 1ns / 1ps

module MIPS_top_module_TB;

	reg clk;
	wire[31:0] data1, data2;
	wire alu_zero;
	wire [31:0] alu_result;
	wire [31:0] pc_in;
	wire [31:0] ins;

	MIPS_top_module uut (
		.clk(clk),
		.data1(data1),
		.data2(data2),
		.alu_zero(alu_zero),
		.alu_result(alu_result),
		.pc_in(pc_in),
		.ins(ins)
	);

	initial begin

		clk = 0;
		//data1 = 0;
		//data2 = 0;
		//alu_zero = 0;
		//alu_result = 0;
		//mux4_out = 0;

		#100;
      
	end
	
	initial repeat (50) #20 clk = ~clk;
 
endmodule

