`timescale 1ns / 1ps

module data_memory(input clk, input [6:0] address, input memWrite, memRead, input [31:0] writeData,
                   output reg [31:0] readData);

	reg [31:0] mem [0:127];
	
	
	always @(posedge clk)
	begin
		if(memWrite && memRead)
		begin
			mem[address] <= writeData;
			readData <= writeData;
		end
		else if(memWrite)
			mem[address] <= writeData;
		else if(memRead)
			if(address == 13)
				readData <= 3;
			else
				readData <= mem[address];
	end

endmodule
