`timescale 1ns / 1ps

module instruction_memory(input clk, input [4:0] address,
                          output reg [31:0] instruction);

	wire [31:0] mem [0:31];
	
	always @*
	begin
		instruction = mem[address];
	end

endmodule
