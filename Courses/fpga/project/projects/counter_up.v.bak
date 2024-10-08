module counter_up(out,up_down,clk,reset);

output [7:0] out;
input up_down,clk,reset;
reg [7:0] out;

always @(posedge clk)

if(reset) begin
out <= 8'b0;
end

else if(up_down) begin
out <= out+1;
end

else begin
out <= out-1;
end

endmodule
