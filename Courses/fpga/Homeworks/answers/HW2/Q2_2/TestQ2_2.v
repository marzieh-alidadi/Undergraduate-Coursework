module pwm_detector_tb;

reg clk;
reg [15:0] pwm_in;
reg low_read, high_read;
wire [15:0] data_out;

pwm_detector pwm_d(clk, pwm_in, high_read, low_read, data_out);

initial
begin

clk=0;

#3
pwm_in=0;
low_read=1;
high_read=0;

#10
pwm_in=1;
low_read=0;
high_read=1;

#100
pwm_in=0;
low_read=1;
high_read=0;

#50
pwm_in=0;
low_read=1;
high_read=0;

#20
low_read=0;
high_read=0;

end

initial repeat (500) #1 clk = ~clk;

always @(data_out)
$display("pwm_in:   ",pwm_in,"        ","low_read:   ",low_read,"        ","high_read:   ",high_read,"        ","data_out:   ",data_out,"        ","time:   ",$time);

endmodule
