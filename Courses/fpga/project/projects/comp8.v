module comp8(input[7:0] In1,input[7:0] In2,output G,output L,output E);

wire[3:0] a1,a2,b1,b2;
wire g1,g2,l1,l2,e1,e2;

assign a1 = In1[3:0];
assign a2 = In1[7:4];
assign b1 = In2[3:0];
assign b2 = In2[7:4];

comp4 BC_1(a1,b1,g1,l1,e1);
comp4 bC_2(a2,b2,g2,l2,e2);

assign E = (e1 & e2);
assign L = (l2 | (e2 & l1));
assign G = (g2 | (e2 & g1));

endmodule