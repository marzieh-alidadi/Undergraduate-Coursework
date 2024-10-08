module mux8_16to1(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,select,o);
input[7:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15;
input [3:0] select;
output[7:0] o;
wire[7:0] o1,o2,o3,o4;

mux8_4to1 m1(a0, a1, a2, a3, select[1:0], o1);
mux8_4to1 m2(a4, a5, a6, a7, select[1:0], o2);
mux8_4to1 m3(a8, a9, a10, a11, select[1:0], o3);
mux8_4to1 m4(a12, a13, a14, a15, select[1:0], o4);

mux8_4to1 m(o1, o2, o3, o4, select[3:2], o);

endmodule
