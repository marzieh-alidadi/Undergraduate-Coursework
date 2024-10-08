module fa8_tb;

reg [7:0] a,b;
reg cin;
wire [7:0] sum;
wire cout;

full_adder8 fa8( a,b,cin, sum,cout);

initial begin
$monitor("%d a=%b, b=%b, cin=%b, sum=%b, cout=%b", $time,a,b,cin,sum,cout );

a=0;
b=0;
cin=0;

#100 a=8'b00110111;b=8'b00000101;cin=1'b0;
#100 a=8'b00110000;b=8'b00000110;cin=1'b0;
#100 a=8'b01011110;b=8'b00000100;cin=1'b0;
#100 a=8'b01101110;b=8'b00000011;cin=1'b0;
#100 a=8'b01101111;b=8'b00000111;cin=1'b0;
#100 a=8'b01110000;b=8'b00001000;cin=1'b0;
#100 a=8'b11111111;b=8'b00000000;cin=1'b1;
end

endmodule
