module mux8_4to1_tb;
reg[7:0] a0,a1,a2,a3;
reg [1:0] select;
wire[7:0] o;
mux8_4to1 m8_4to1(a0,a1,a2,a3, select, o);


initial begin
$monitor("%d a0=%b, a1=%b, a2=%b, a3=%b, select=%b, o=%b", $time,a0,a1,a2,a3,select,o );

a0=0;
a1=0;
a2=0;
a3=0;
select=0;

#100 a0=8'b00000000;a1=8'b10000001;a2=8'b00000010;a3=8'b10000011;select=2'b00;
#100 a0=8'b00000000;a1=8'b10000001;a2=8'b00000010;a3=8'b10000011;select=2'b01;
#100 a0=8'b00000000;a1=8'b10000001;a2=8'b00000010;a3=8'b10000011;select=2'b10;
#100 a0=8'b00000000;a1=8'b10000001;a2=8'b00000010;a3=8'b10000011;select=2'b11;

end

endmodule
