`timescale 1ns / 1ps

module instruction_memory(input clk, input [4:0] address,
                          output reg [31:0] instruction);

	wire [31:0] mem [0:31];
	
	//1
	assign mem[0] = 32'b001000_00000_00001_0000000000000011;
	assign mem[1] = 32'b001000_00000_00001_0000000000000011;
	assign mem[2] = 32'b001000_00000_00001_0000000000000011;
	
	assign mem[3] = 32'b001000_00000_00010_0000000000000011;
	assign mem[4] = 32'b001000_00000_00010_0000000000000011;
	assign mem[5] = 32'b001000_00000_00010_0000000000000011;
	
	assign mem[6] = 32'b000000_00001_00010_00011_00000_011000;
	assign mem[7] = 32'b000000_00001_00010_00011_00000_011000;
	assign mem[8] = 32'b000000_00001_00010_00011_00000_011000;
	
	always @*
	begin
		instruction = mem[address];
	end

endmodule
