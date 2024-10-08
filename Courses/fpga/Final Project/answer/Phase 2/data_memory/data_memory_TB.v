`timescale 1ns / 1ps

module data_memory_TB;

	reg clk;
	reg [6:0] address;
	reg memWrite;
	reg memRead;
	reg [31:0] writeData;

	wire [31:0] readData;

	data_memory uut (
		.clk(clk), 
		.address(address), 
		.memWrite(memWrite), 
		.memRead(memRead), 
		.writeData(writeData), 
		.readData(readData)
	);

	initial begin

		clk = 0;
		address = 0;
		memWrite = 0;
		memRead = 0;
		writeData = 0;

		#60;
		address = 125;
		memWrite = 1;
		memRead = 0;
		writeData = 25;
		
		#60;
		address = 16;
		memWrite = 1;
		memRead = 0;
		writeData = 5;
		
		#60;
		address = 125;
		memWrite = 0;
		memRead = 1;
		writeData = 0;
		
		#60;
		address = 125;
		memWrite = 1;
		memRead = 1;
		writeData = 0;
		
	end
	
	initial repeat (30) #20 clk = ~clk;
      
endmodule

