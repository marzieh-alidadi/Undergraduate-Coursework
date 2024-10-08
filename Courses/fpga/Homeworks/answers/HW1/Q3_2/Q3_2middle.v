module mux8_4to1(a0,a1,a2,a3,select,o);
input[7:0] a0,a1,a2,a3;
input [1:0] select;
output[7:0] o;

mux1_4to1 m1(a0[0], a1[0], a2[0], a3[0], select, o[0]);
mux1_4to1 m2(a0[1], a1[1], a2[1], a3[1], select, o[1]);
mux1_4to1 m3(a0[2], a1[2], a2[2], a3[2], select, o[2]);
mux1_4to1 m4(a0[3], a1[3], a2[3], a3[3], select, o[3]);
mux1_4to1 m5(a0[4], a1[4], a2[4], a3[4], select, o[4]);
mux1_4to1 m6(a0[5], a1[5], a2[5], a3[5], select, o[5]);
mux1_4to1 m7(a0[6], a1[6], a2[6], a3[6], select, o[6]);
mux1_4to1 m8(a0[7], a1[7], a2[7], a3[7], select, o[7]);

endmodule
