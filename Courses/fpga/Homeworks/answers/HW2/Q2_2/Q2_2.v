module pwm_detector(clk, pwm_in, high_read, low_read, data_out);

input clk;
input [15:0] pwm_in;
input low_read, high_read;
output reg [15:0] data_out;

integer counterL=0,counterH=0;
reg [15:0] currentPwm=0;
integer zCounter=0;

always @(posedge clk) begin

if(low_read==1)
begin
  if(pwm_in==0)
  begin
    counterL=counterL+1;
  end
end

else if(high_read==1)
begin
  if(pwm_in==1)
  begin
    counterH=counterH+1;
  end
end

else if(high_read==0 && low_read==0)
  begin
  data_out=16'bzzzzzzzzzzzzzzzz;
  end

end

always @(posedge clk) begin

if(pwm_in!=currentPwm)
  if(pwm_in==0 && counterH!=0)
  begin
    data_out=counterH;
    counterH=0;
  end
  if(pwm_in==1 && counterL!=0)
  begin
    data_out=counterL;
    counterL=0;
  end
  if(high_read==0 && low_read==0)
  begin
    if(counterH!=0)
    begin
      data_out=counterH;
      counterH=0;
    end
    if(counterL!=0)
    begin
      data_out=counterL;
      counterL=0;
    end
  end
  currentPwm=pwm_in;
end

endmodule
