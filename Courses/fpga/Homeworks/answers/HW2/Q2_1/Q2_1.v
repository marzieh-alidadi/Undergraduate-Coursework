module pwm_generator(clk,data_in,low_write,high_write,pwm_out);

input clk;
input [15:0] data_in;
input low_write, high_write;
output reg [15:0] pwm_out;
reg [15:0] low_time=0, high_time=0;

reg [15:0] currentData=0;
reg current_low=0,current_high=0;

reg turn=1;
integer counterL=0,counterH=0;

always @(posedge clk) begin

  if(currentData!=data_in || low_write!=current_low || high_write!=current_high)
  begin
    if(low_write==1'b1)
    begin
      low_time=data_in;
      counterL=data_in;
    end
    if(high_write==1'b1)
    begin
      high_time=data_in;
      counterH=data_in;
    end
    currentData=data_in;
    current_low=low_write;
    current_high=high_write;
  end

  if(turn==1 && counterH)
  begin
    pwm_out<=1;
    counterH=counterH-1;
    if(counterH==0)
    begin
      turn=0;
      counterL=low_time;
    end
  end
  else if(turn==0 && counterL)
  begin
    pwm_out<=0;
    counterL=counterL-1;
    if(counterL==0)
    begin
      turn=1;
      counterH=high_time;
    end
  end

end

endmodule
