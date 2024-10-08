module timerPlus(clk,start,stop,reset,year,month,day,hour,minute,second);

input clk,start,stop,reset;
output [7:0] second, minute, hour, day, month, year;

wire out_sec=1'b0, out_min=1'b0, out_hr=1'b0 ,out_dy=1'b0 ,out_mnt=1'b0 ,out_yr=1'b0;

wire set;
assign set= clk && start && !stop ? 1 : 0;

pCounterPlus #(59) secP(set,reset,out_sec,second);

pCounterPlus #(59) minP(out_sec,reset,out_min,minute);

pCounterPlus #(23) hrP(out_min,reset,out_hr,hour);

pCounterPlus #(29) dyP(out_hr,reset,out_dy,day);

pCounterPlus #(11) mntP(out_dy,reset,out_mnt,month);

pCounterPlus #(10) yrP(out_mnt,reset,out_yr,year);

endmodule
