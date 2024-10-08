module sub_add8( a,b,cin,op,result,cout);
input[7:0] a,b;
input cin,op;
output[7:0] result;
output cout;
wire[6:0] c;
wire notop;
wire[7:0] bin;


assign notop = op ? 1'b0 : 1'b1;
assign cin = notop;

assign bin[0] = b[0] ^ notop;
assign bin[1] = b[1] ^ notop;
assign bin[2] = b[2] ^ notop;
assign bin[3] = b[3] ^ notop;
assign bin[4] = b[4] ^ notop;
assign bin[5] = b[5] ^ notop;
assign bin[6] = b[6] ^ notop;
assign bin[7] = b[7] ^ notop;


full_adder1 f1(a[0],bin[0],cin,result[0],c[0]);
full_adder1 f2(a[1],bin[1],c[0],result[1],c[1]);
full_adder1 f3(a[2],bin[2],c[1],result[2],c[2]);
full_adder1 f4(a[3],bin[3],c[2],result[3],c[3]);
full_adder1 f5(a[4],bin[4],c[3],result[4],c[4]);
full_adder1 f6(a[5],bin[5],c[4],result[5],c[5]);
full_adder1 f7(a[6],bin[6],c[5],result[6],c[6]);
full_adder1 f8(a[7],bin[7],c[6],result[7],cout);
endmodule
