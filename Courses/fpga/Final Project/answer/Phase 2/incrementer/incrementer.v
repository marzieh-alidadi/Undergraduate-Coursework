`timescale 1ns / 1ps

module incrementer(input [31:0] in,
                   output reg [31:0] in_plus);

	always @*
	begin
		in_plus = in + 1;
	end

endmodule
