`timescale 1ns / 1ps

module register_bank_TB;

	reg clk;
	reg regWrite;
	reg [4:0] readRegister1;
	reg [4:0] readRegister2;
	reg [4:0] writeRegister;
	reg [31:0] writeData;

	wire [31:0] readData1;
	wire [31:0] readData2;

	register_bank uut (
		.clk(clk), 
		.regWrite(regWrite), 
		.readRegister1(readRegister1), 
		.readRegister2(readRegister2), 
		.writeRegister(writeRegister), 
		.writeData(writeData), 
		.readData1(readData1), 
		.readData2(readData2)
	);

	initial begin

		clk = 0;
		regWrite = 0;
		readRegister1 = 0;
		readRegister2 = 0;
		writeRegister = 0;
		writeData = 0;

		#60;
		regWrite = 1;
		readRegister1 = 0;
		readRegister2 = 0;
		writeRegister = 1;
		writeData = 12;
		
		#60;
		regWrite = 1;
		readRegister1 = 0;
		readRegister2 = 0;
		writeRegister = 3;
		writeData = 15;

		#60;
		regWrite = 1;
		readRegister1 = 1;
		readRegister2 = 3;
		writeRegister = 3;
		writeData = 16;
		
		#60;
		regWrite = 1;
		readRegister1 = 1;
		readRegister2 = 1;
		writeRegister = 3;
		writeData = 16;
		
		#60;
		regWrite = 1;
		readRegister1 = 0;
		readRegister2 = 0;
		writeRegister = 3;
		writeData = 16;
		
	end
	
		initial repeat (30) #20 clk = ~clk;
      
endmodule

