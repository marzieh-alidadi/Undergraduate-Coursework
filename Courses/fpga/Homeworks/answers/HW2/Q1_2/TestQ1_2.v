module timer_tb;

reg clk;
wire [7:0] second, minute, hour, day, month, year;

timer t(clk,year,month,day,hour,minute,second);

initial
begin

clk=0;

end

initial repeat (200000) #1 clk = ~clk;

always @(posedge clk)
$display("year:   ",year,"        ","month:   ",month,"        ","day:   ",day,"        ","hour:   ",hour,"        ","minute:   ",minute,"        ","second:   ",second,"        ","time:   ",$time);



endmodule
