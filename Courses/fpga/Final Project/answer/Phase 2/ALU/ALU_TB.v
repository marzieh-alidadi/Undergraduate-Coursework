`timescale 1ns / 1ps

module ALU_TB;

	reg clk;
	reg [3:0] operation;
	reg [31:0] in1;
	reg [31:0] in2;

	wire zero;
	wire [31:0] result;

	ALU uut (
		.clk(clk), 
		.operation(operation), 
		.in1(in1), 
		.in2(in2), 
		.zero(zero), 
		.result(result)
	);

	initial begin

		clk = 0;
		operation = 4'b0000;
		in1 = 32'b11011111001;
		in2 = 32'b110110010001;

		#75;
      operation = 4'b0001;
		in1 = 32'b110110010001;
		in2 = 32'b110110010001;

		#75;
      operation = 4'b0010;
		in1 = 32'b11011111001;
		in2 = 32'b110110010001;
		
		#75;
      operation = 4'b0110;
		in1 = 32'b11011111001;
		in2 = 32'b110110010001;
		
		#85;
      operation = 4'b0111;
		in1 = 32'b11011111001;
		in2 = 32'b110110010001;
		
		#75;
      operation = 4'b1100;
		in1 = 32'b11011111001;
		in2 = 32'b11011111001;
		
	end
	
	initial repeat (30) #20 clk = ~clk;

      
endmodule

