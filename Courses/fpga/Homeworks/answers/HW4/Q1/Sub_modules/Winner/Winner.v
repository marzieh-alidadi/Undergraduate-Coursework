`timescale 1ns / 1ps

module Winner(input newClk, input [9:0] out_cr,
				  output reg [1:0] out_wr);
	
	reg [1:0] temp;
	reg [1:0] prev_wr1=2'b00;
	reg [1:0] prev_wr2=2'b00;
	
	integer first_cnt=0, second_cnt=0, i;
	
	always @(newClk) begin//new clk is using with both edges
		first_cnt=0;
		second_cnt=0;
		
		if(out_cr==10'b0000000000)
		begin
			out_wr<=2'b00;
			prev_wr1=2'b00;
			prev_wr2=2'b00;
		end
		else
		begin
		temp=out_cr[1:0];
		if(temp==2'b01)
			first_cnt=first_cnt+1;
		else if(temp==2'b10)
			second_cnt=second_cnt+1;
		else if(temp==2'b11)
		begin
			first_cnt=first_cnt+1;
			second_cnt=second_cnt+1;
		end
		
		temp=out_cr[3:2];
		if(temp==2'b01)
			first_cnt=first_cnt+1;
		else if(temp==2'b10)
			second_cnt=second_cnt+1;
		else if(temp==2'b11)
		begin
			first_cnt=first_cnt+1;
			second_cnt=second_cnt+1;
		end
		
		temp=out_cr[5:4];
		if(temp==2'b01)
			first_cnt=first_cnt+1;
		else if(temp==2'b10)
			second_cnt=second_cnt+1;
		else if(temp==2'b11)
		begin
			first_cnt=first_cnt+1;
			second_cnt=second_cnt+1;
		end
		
		temp=out_cr[7:6];
		if(temp==2'b01)
			first_cnt=first_cnt+1;
		else if(temp==2'b10)
			second_cnt=second_cnt+1;
		else if(temp==2'b11)
		begin
			first_cnt=first_cnt+1;
			second_cnt=second_cnt+1;
		end
		
		temp=out_cr[9:8];
		if(temp==2'b01)
			first_cnt=first_cnt+1;
		else if(temp==2'b10)
			second_cnt=second_cnt+1;
		else if(temp==2'b11)
		begin
			first_cnt=first_cnt+1;
			second_cnt=second_cnt+1;
		end
		
		if(first_cnt>second_cnt)
			prev_wr2=2'b01;
		else if(first_cnt<second_cnt)
			prev_wr2=2'b10;
		else if(first_cnt==second_cnt && first_cnt!=0)
			prev_wr2=2'b11;
		else
			prev_wr2=2'b00;
	
		out_wr<=prev_wr1;
		prev_wr1=prev_wr2;
		
		end
		
	end
	
endmodule
