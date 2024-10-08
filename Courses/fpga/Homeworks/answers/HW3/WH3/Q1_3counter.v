module pCounterPlus(clk,reset,out,cnt_out);

input clk, reset;
output reg out=1'b0;
output reg [7:0] cnt_out=0;
parameter [7:0] p=10;
reg curReset;

always @(negedge reset or posedge clk) begin

if(reset==0)
begin
	cnt_out<=0;
end
else
begin
	if(cnt_out==p)
	begin
		out=1'b1;
		cnt_out<=0;
	end
	else
	begin
		cnt_out<=cnt_out+1;
		out=1'b0;
	end
end

end

endmodule
