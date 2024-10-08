module fa1_tb;
reg  a,b,cin;
wire sum,cout;

full_adder1 fa1( a,b,cin, sum,cout);


initial begin
$monitor("%d a=%b, b=%b, cin=%b, sum=%b, cout=%b", $time,a,b,cin,sum,cout );

a=0;
b=0;
cin=0;

#100 a=1'b0;b=1'b0;cin=1'b0;
#100 a=1'b0;b=1'b1;cin=1'b0;
#100 a=1'b1;b=1'b0;cin=1'b0;
#100 a=1'b1;b=1'b1;cin=1'b0;

#100 a=1'b0;b=1'b0;cin=1'b1;
#100 a=1'b0;b=1'b1;cin=1'b1;
#100 a=1'b1;b=1'b0;cin=1'b1;
#100 a=1'b1;b=1'b1;cin=1'b1;

end



endmodule
