module seq_detector(seq_input, clk, seq_select, reset, seq_number, seq_detected);
input seq_input, clk, reset;
input[0:1] seq_select;
output reg seq_detected;
output reg [7:0] seq_number;
parameter[2:0] s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;
reg[2:0] current;


always @(posedge clk)
begin

if(reset)
begin
 current = s0;
 seq_number=8'b00000000;
end

else if(seq_select == 2'b00)
begin
case(current)
s0: if(seq_input) current <= s1; else current <= s0;
s1: if(seq_input) current <= s2; else current <= s0;
s2: if(seq_input) current <= s2; else current <= s3;
s3: if(seq_input) current <= s1; else current <= s4;
s4: if(seq_input) current <= s1; else current <= s0;
endcase
end

else if(seq_select == 2'b01)
begin
case(current)
s0: if(seq_input) current <= s1; else current <= s0;
s1: if(seq_input) current <= s1; else current <= s2;
s2: if(seq_input) current <= s3; else current <= s0;
s3: if(seq_input) current <= s1; else current <= s4;
s4: if(seq_input) current <= s1; else current <= s0;
endcase
end

else if(seq_select == 2'b10)
begin
case(current)
s0: if(seq_input) current <= s0; else current <= s1;
s1: if(seq_input) current <= s2; else current <= s1;
s2: if(seq_input) current <= s3; else current <= s1;
s3: if(seq_input) current <= s0; else current <= s4;
s4: if(seq_input) current <= s0; else current <= s1;
endcase
end

else if(seq_select == 2'b11)
begin
case(current)
s0: if(seq_input) current <= s1; else current <= s0;
s1: if(seq_input) current <= s1; else current <= s2;
s2: if(seq_input) current <= s1; else current <= s3;
s3: if(seq_input) current <= s4; else current <= s0;
s4: if(seq_input) current <= s1; else current <= s0;
endcase
end

end

always @(current)
begin

if(current == s4)
begin
seq_detected = 1'b1;
seq_number = seq_number +1;
end

else seq_detected = 1'b0;

end

endmodule
