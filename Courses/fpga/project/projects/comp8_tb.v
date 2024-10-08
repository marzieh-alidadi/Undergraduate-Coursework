module comp8_TB;

reg[7:0] a,b;
wire e,l,g;

comp8 BC_1(a,b,g,l,e);

initial begin

$monitor("%d a=%b, b=%b, g=%b, l=%b, e=%b", $time, a,b,g,l,e);

#20
a=8'h0f;
b=8'h0f;

#20
a=8'h0f;
b=8'h00;

#20
a=8'h00;
b=8'h0f;

#20
a=8'h07;
b=8'h0f;

end

endmodule