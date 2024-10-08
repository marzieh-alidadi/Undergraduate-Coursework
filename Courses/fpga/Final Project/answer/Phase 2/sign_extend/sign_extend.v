`timescale 1ns / 1ps

module sign_extend(input clk, input [15:0] in,
    output reg [31:0] in_extend);

	always @(posedge clk)
	begin
		in_extend <= { {16{in[15]}}, in };
	end

endmodule
