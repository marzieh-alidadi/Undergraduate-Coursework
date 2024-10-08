module full_adder8( a,b,cin, sum,cout);
input[7:0] a,b;
input cin;
output[7:0] sum;
output cout;
wire[6:0] c;

full_adder1 f1(a[0],b[0],cin,sum[0],c[0]);
full_adder1 f2(a[1],b[1],c[0],sum[1],c[1]);
full_adder1 f3(a[2],b[2],c[1],sum[2],c[2]);
full_adder1 f4(a[3],b[3],c[2],sum[3],c[3]);
full_adder1 f5(a[4],b[4],c[3],sum[4],c[4]);
full_adder1 f6(a[5],b[5],c[4],sum[5],c[5]);
full_adder1 f7(a[6],b[6],c[5],sum[6],c[6]);
full_adder1 f8(a[7],b[7],c[6],sum[7],cout);
endmodule