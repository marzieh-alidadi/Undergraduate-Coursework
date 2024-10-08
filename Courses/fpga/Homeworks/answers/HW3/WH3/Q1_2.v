module timer(clk,year,month,day,hour,minute,second);

input clk;
output [7:0] second, minute, hour, day, month, year;

wire out_sec, out_min, out_hr, out_dy, out_mnt, out_yr;

pCounter #(59) sec(clk,out_sec,second);

pCounter #(59) min(out_sec,out_min,minute);

pCounter #(23) hr(out_min,out_hr,hour);

pCounter #(29) dy(out_hr,out_dy,day);

pCounter #(11) mnt(out_dy,out_mnt,month);

pCounter #(10) yr(out_mnt,out_yr,year);

endmodule
