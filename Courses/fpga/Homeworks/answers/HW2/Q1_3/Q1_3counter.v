module pCounterPlus(clk,reset,out,cnt_out);

input clk, reset;
output reg out=1'b0;
output reg [7:0] cnt_out=0;
parameter [7:0] p=10;

always @(posedge clk) begin

if(cnt_out==p)
begin
out=1'b1;
cnt_out=0;
end
else if(cnt_out==p-1)
begin
out=1'b0;
cnt_out=cnt_out+1;
end
else
begin
cnt_out=cnt_out+1;
out=0;
end

end

always@(reset) begin

if(reset==0)
cnt_out=0;

end

endmodule
