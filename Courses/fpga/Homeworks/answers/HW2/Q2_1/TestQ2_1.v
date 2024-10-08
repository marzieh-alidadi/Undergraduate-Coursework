module pwm_generator_tb;

reg clk;
reg [15:0] data_in;
reg low_write, high_write;
wire [15:0] pwm_out;

pwm_generator pwm_g(clk,data_in,low_write,high_write,pwm_out);

initial
begin

clk=0;

#2
data_in=10;
low_write=1;
high_write=0;

#10
data_in=5;
low_write=0;
high_write=1;

#200
data_in=20;
low_write=1;
high_write=1;

#200
data_in=10;
low_write=1;
high_write=0;

end

initial repeat (1000) #2 clk = ~clk;

always @(pwm_out)
$display("pwm_out:   ",pwm_out,"        ","data_in:   ",data_in,"        ","low_write:   ",low_write,"        ","high_write:   ",high_write,"        ","time:   ",$time);

endmodule
