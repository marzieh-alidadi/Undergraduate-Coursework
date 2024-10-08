module timerPlus_tb;

reg clk,start,stop,reset;
wire [7:0] second, minute, hour, day, month, year;

timerPlus tP(clk,start,stop,reset,year,month,day,hour,minute,second);

initial
begin

clk=0;
reset=1;
start=0;
stop=0;

#10
start=1;

#200
reset=0;
#2
reset=1;

#100
stop=1;
#10
stop=0;

#7000
reset=0;
#2
reset=1;

end

initial repeat (200000) #1 clk = ~clk;

always @(posedge clk)
$display("start:   ",start,"        ","stop:   ",stop,"        ","reset:   ",reset,"        ","year:   ",year,"        ","month:   ",month,"        ","day:   ",day,"        ","hour:   ",hour,"        ","minute:   ",minute,"        ","second:   ",second,"        ","time:   ",$time);



endmodule
