module sa8_tb;

reg [7:0] a,b;
reg cin,op;
wire [7:0] result;
wire cout;

add_subb8 as8( a,b,cin,op,result,cout);

initial begin
$monitor("%d a=%b, b=%b, op=%b, result=%b", $time,a,b,op,result );

a=0;
b=0;
cin=0;
op=0;

#100 a=8'b00110111;b=8'b00000101;cin=1'b1;op=0;
#100 a=8'b00110000;b=8'b00000110;cin=1'b1;op=0;
#100 a=8'b01011110;b=8'b00000100;cin=1'b1;op=0;
#100 a=8'b01101110;b=8'b00000011;cin=1'b1;op=0;
#100 a=8'b01101111;b=8'b00000111;cin=1'b1;op=0;
#100 a=8'b01110000;b=8'b00001000;cin=1'b1;op=0;
#100 a=8'b11111111;b=8'b00000000;cin=1'b1;op=0;


#100 a=8'b00110111;b=8'b00000101;cin=1'b0;op=1;
#100 a=8'b00110000;b=8'b00000110;cin=1'b0;op=1;
#100 a=8'b01011110;b=8'b00000100;cin=1'b0;op=1;
#100 a=8'b01101110;b=8'b00000011;cin=1'b0;op=1;
#100 a=8'b01101111;b=8'b00000111;cin=1'b0;op=1;
#100 a=8'b01110000;b=8'b00001000;cin=1'b0;op=1;
#100 a=8'b11111111;b=8'b00000000;cin=1'b0;op=1;


end

endmodule
