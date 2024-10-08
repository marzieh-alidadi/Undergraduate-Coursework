module comp4 (In1,In2,G,L,E);

input In1,In2;
output G,L,E;
reg G,L,E;

always @ (In1,In2)
begin

G <= (In1>In2) ? 1'b1 : 1'b0;
L <= (In1<In2) ? 1'b1 : 1'b0;
E <= (In1==In2) ? 1'b1 : 1'b0;

end

endmodule