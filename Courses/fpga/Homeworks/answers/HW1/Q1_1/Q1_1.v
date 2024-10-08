module full_adder1(input a,b,cin,output sum,cout);
reg[1:0] temp;
always @(*)
begin
temp = {1'b0,a}+ {1'b0,b}+ {1'b0,cin};
end
assign sum = temp[0];
assign cout = temp[1];
endmodule
