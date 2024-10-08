module pCounter_tb;

reg clk;
wire out;
wire [7:0] cnt_out;
pCounter #(20) pC (clk,out,cnt_out);

initial
begin

clk=0;

end

initial repeat (150) #3 clk = ~clk;

always @(posedge clk)
$display("out:   ",out,"        ","cnt_out:   ",cnt_out,"        ","time:   ",$time);


endmodule
