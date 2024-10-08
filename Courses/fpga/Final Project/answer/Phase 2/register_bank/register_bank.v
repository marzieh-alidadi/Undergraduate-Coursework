`timescale 1ns / 1ps

module register_bank(input clk, regWrite, input [4:0] readRegister1, readRegister2, writeRegister, input [31:0] writeData,
                     output [31:0] readData1, readData2);

	reg [31:0] mem [0:31];

	assign readData1 = readRegister1 ? mem[readRegister1] : 0;
	assign readData2 = readRegister2 ? mem[readRegister2] : 0;

	always @(posedge clk)
	begin
		if(regWrite)
		begin
			mem[writeRegister] <= writeData;
		end
	end

endmodule
