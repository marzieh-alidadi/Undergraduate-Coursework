module pCounterPlus_tb;

reg clk,reset;
wire out;
wire [7:0] cnt_out;
pCounterPlus #(20) pCP (clk,reset,out,cnt_out);

initial
begin

clk=0;
reset=1;

#20
reset=0;
#6
reset=1;

#50
reset=0;
#6
reset=1;

end

initial repeat (150) #3 clk = ~clk;

always @(cnt_out)
$display("reset:   ",reset,"        ","out:   ",out,"        ","cnt_out:   ",cnt_out,"        ","time:   ",$time);


endmodule
