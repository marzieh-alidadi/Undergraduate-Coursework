//you should just uncomment each mode that you want yo test :)

module seq_detector_tb;
reg seq_input, clk, reset;
reg[0:1] seq_select;
wire seq_detected;
wire [7:0] seq_number;
seq_detector sd(seq_input, clk, seq_select, reset, seq_number, seq_detected);

//for mode 1100

initial
begin
seq_input = 0; clk = 0; reset = 1;
seq_select=2'b00;
end

initial repeat (44) #7 clk = ~clk;
initial repeat (15) #23 seq_input=~seq_input;

initial
begin
#31 reset=1;
#23 reset=0;
end

always @(seq_detected)
if(seq_detected==1) $display("1100","     ","seq_select: mode ",seq_select +1,"     ","seq_number:",seq_number,"     ","time:",$time);



//for mode 1010
/*
initial
begin
seq_input = 0; clk = 0; reset = 1;
seq_select=2'b01;
end

initial repeat (70) #7 clk = ~clk;
initial repeat (40) #20 seq_input=~seq_input;

initial
begin
#31 reset=1;
#23 reset=0;
end

always @(seq_detected)
if(seq_detected==1) $display("1010","     ","seq_select: mode ",seq_select +1,"     ","seq_number:",seq_number,"     ","time:",$time);
*/

//for mode 0110
/*
initial
begin
seq_input = 0; clk = 0; reset = 1;
seq_select=2'b10;
end

initial repeat (44) #14 clk = ~clk;
initial repeat (25) #23 seq_input=~seq_input;

initial
begin
#31 reset=1;
#23 reset=0;
end

always @(seq_detected)
if(seq_detected==1) $display("0110","     ","seq_select: mode ",seq_select +1,"     ","seq_number:",seq_number,"     ","time:",$time);
*/

//for mode 1001
/*
initial
begin
seq_input = 0; clk = 0; reset = 1;
seq_select=2'b11;
end

initial repeat (44) #14 clk = ~clk;
initial repeat (25) #23 seq_input=~seq_input;

initial
begin
#31 reset=1;
#23 reset=0;
end

always @(seq_detected)
if(seq_detected==1) $display("1001","     ","seq_select: mode ",seq_select +1,"     ","seq_number:",seq_number,"     ","time:",$time);
*/



endmodule
