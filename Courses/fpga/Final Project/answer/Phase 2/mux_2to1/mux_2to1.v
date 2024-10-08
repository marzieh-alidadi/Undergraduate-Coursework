`timescale 1ns / 1ps

module mux_2to1(input [31:0] in1, in2, input select,
                output reg [31:0] out);

	always @*
	begin
		if(select)
			out = in1;
		else
			out = in2;
	end

endmodule
