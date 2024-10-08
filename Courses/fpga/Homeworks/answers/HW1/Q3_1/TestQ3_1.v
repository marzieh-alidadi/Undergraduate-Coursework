module mux1_4to1_tb;
reg a,b,c,d;
reg [1:0] select;
wire o;
mux1_4to1 m1_4to1(a, b, c, d, select, o);


initial begin
$monitor("%d a=%b, b=%b, c=%b, d=%b, select=%b, o=%b", $time,a,b,c,d,select,o );

a=0;
b=0;
c=0;
d=0;
select=0;

#100 a=1'b1;b=1'b0;c=1'b0;d=1'b0;select=2'b00;
#100 a=1'b0;b=1'b1;c=1'b0;d=1'b0;select=2'b01;
#100 a=1'b0;b=1'b0;c=1'b1;d=1'b0;select=2'b10;
#100 a=1'b0;b=1'b0;c=1'b0;d=1'b1;select=2'b11;


#100 a=1'b0;b=1'b1;c=1'b1;d=1'b1;select=2'b00;
#100 a=1'b1;b=1'b0;c=1'b1;d=1'b1;select=2'b01;
#100 a=1'b1;b=1'b1;c=1'b0;d=1'b1;select=2'b10;
#100 a=1'b1;b=1'b1;c=1'b1;d=1'b0;select=2'b11;


end

endmodule
