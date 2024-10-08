`timescale 1ns / 1ps

module Winner_tb;

	reg [9:0] out_cr;
	reg newClk;

	wire [1:0] out_wr;

	Winner uut (
		.out_cr(out_cr), 
		.newClk(newClk),
		.out_wr(out_wr)
	);

	initial begin
		out_cr = 0;
		newClk=0;
		
		#10
		out_cr=10'b1010111010;
		
		#20
		out_cr=10'b0011011010;
		
		#20
		out_cr=10'b1001000111;
		
		#20
		out_cr=10'b1110010011;
		
		#20
		out_cr=10'b0000000000;
		
		#20
		out_cr=10'b0111111010;
	end
	
	initial repeat (20) #20 newClk = ~newClk;
      
endmodule