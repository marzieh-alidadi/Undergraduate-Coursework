`timescale 1ns / 1ps

module Correlation #(parameter N=8)(input [N-1:0] target_num, first_num, second_num,
												input clk, input reset, output reg [9:0] out_cr=0, output reg [1:0] correct_guess);
	
	integer first_cnt, second_cnt, cnt;
	reg [2:0] counter=0;
	
	always @(posedge clk,posedge reset) begin
		if(reset==1)
		begin
			out_cr=10'b000000000;
			correct_guess=2'b00;
			counter=0;
		end
		else
		begin
		if(first_num==target_num)
			correct_guess=2'b01;
		if(second_num==target_num)
			correct_guess=2'b10;
		if(first_num==target_num && second_num==target_num)
			correct_guess=2'b11;
		if(first_num!=target_num && second_num!=target_num)
			correct_guess=2'b00;
		cnt=0;
		first_cnt=corrFunc(target_num, first_num, cnt);
		cnt=0;
		second_cnt=corrFunc(target_num, second_num, cnt);
		if(first_cnt>second_cnt)
		begin
			if(counter==0)
				out_cr=10'b0000000001;
			else
				out_cr=(out_cr<<2)+ 10'b0000000001;
		end
		else if(first_cnt<second_cnt)
		begin
			if(counter==0)
				out_cr=10'b0000000010;
			else
				out_cr=(out_cr<<2)+ 10'b0000000010;
		end
		else if(first_cnt==second_cnt)
		begin
			if(counter==0)
				out_cr=10'b0000000011;
			else
				out_cr=(out_cr<<2)+ 10'b0000000011;
		end
		counter=counter+1;
		counter=counter%5;
		end
	end
	
	function [31:0] corrFunc;
		
		input [N-1:0] target_num,	num;
		input [31:0] cnt;
		integer i;
		begin
			for(i=0;i<N;i=i+1)
				if(target_num[i]==num[i])
					cnt=cnt+1;
			corrFunc=cnt;
		end
	endfunction
	
endmodule
