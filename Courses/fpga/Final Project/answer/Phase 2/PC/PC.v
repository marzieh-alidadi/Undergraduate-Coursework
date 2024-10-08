`timescale 1ns / 1ps

module PC(input clk, input [31:0] in,
          output reg [31:0] out);

	always @(posedge clk)
	begin
		out <= in;
	end

endmodule
