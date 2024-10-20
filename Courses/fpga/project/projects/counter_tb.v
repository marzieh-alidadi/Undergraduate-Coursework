module counter_tb();

reg up_down,clk,reset;
wire [7:0] out;

counter_up dut(out,up_down,clk,reset);

initial begin
clk=0;
forever #5 clk=~clk;
end

initial begin

$monitor("%d reset=%b, up_down=%b, out=%b", $time,reset,up_down,out );

reset=1;
up_down=1;

#20
reset=0;

#60
up_down=0;

#40
up_down=1;

end

endmodule
