`timescale 1ns / 1ps

module ALU(input clk, input [3:0] operation, input [31:0] in1, in2,
           output reg zero, output reg [31:0] result);
	
	always @(posedge clk)
	begin
		if(in1 == in2)
			zero <= 1;
		else
			zero <= 0;
		case(operation)
			4'b0000: result <= in1 & in2;
			4'b0001: result <= in1 | in2;
			4'b0010: result <= in1 + in2;
			4'b0110: result <= in1 - in2;
			4'b0111:
				begin
					if(in1 > in2)
						result <= in2;
					if(in2 > in1)
						result <= in1;
				end
			4'b1100: result <= ~(in1 | in2);
			default: result <= 0;
		endcase
	end

endmodule
