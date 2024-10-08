`timescale 1ns / 1ps

module Frequency_division(input clk, reset,
								  output reg newClk=0);
		
	reg [2:0] cnt=0;

	always @(posedge clk, posedge reset) begin
		if(reset==1)
		begin
			cnt=0;
			newClk<=0;
		end
		else
		begin
		if(cnt==0)
			if(newClk==1)
				newClk<=0;
			else if(newClk==0)
				newClk<=1;
		cnt=cnt+1;
		cnt=cnt%5;
		end
	end
	
endmodule
