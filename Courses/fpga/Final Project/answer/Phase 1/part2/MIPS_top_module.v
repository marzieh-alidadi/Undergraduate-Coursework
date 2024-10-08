`timescale 1ns / 1ps

module MIPS_top_module(input clk,
                       output [31:0] data1, data2, output alu_zero, output [31:0] alu_result, output [31:0] pc_in, ins);

	wire [31:0] mux4_out, ins_extend, wr_reg, mux3_out, r_data, next_pc, Add_out, current_pc;
	wire [3:0] alu_cont_out;
	wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite;
   wire [1:0] ALUop;
		
	PC pc(.clk(clk), .in(pc_in), .out(current_pc));
	
	incrementer add_1(.in(current_pc), .in_plus(next_pc));
	//add add_1(.in1(current_pc), in2(1), .out(next_pc));

	add Add(.in1(next_pc), .in2(ins_extend), .out(Add_out));
	
	mux_2to1 mux1(.in1(Add_out), .in2(next_pc), .select(Branch && alu_zero), .out(pc_in));
	
	instruction_memory ins_mem(.clk(clk), .address(current_pc), .instruction(ins));
	
	sign_extend sign_ext(.clk(clk), .in(ins[15:0]), .in_extend(ins_extend));
	
	ALU_control alu_control(.ALU_op(ALUop), .inst(ins[5:0]), .op(alu_cont_out));
	
	mux_2to1 mux2(.in1(ins[15:11]), .in2(ins[20:16]), .select(RegDst), .out(wr_reg));
	
	register_bank registers(.clk(clk), .regWrite(RegWrite), .readRegister1(ins[25:21]), .readRegister2(ins[20:16]), .writeRegister(wr_reg), .writeData(mux4_out), .readData1(data1), .readData2(data2));
	
	mux_2to1 mux3(.in1(ins_extend), .in2(data2), .select(ALUsrc), .out(mux3_out));
	
	ALU alu(.clk(clk), .operation(alu_cont_out), .in1(data1), .in2(mux3_out), .zero(alu_zero), .result(alu_result));	
	
	Control control(.inst_in(ins[31:26]), .RegDst(RegDst), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .ALUop(ALUop), .MemWrite(MemWrite), .ALUsrc(ALUsrc), .RegWrite(RegWrite));
	
	data_memory data_mem(.clk(clk), .address(alu_result), .memWrite(MemWrite), .memRead(MemRead), .writeData(data2), .readData(r_data));
	
	mux_2to1 mux4(.in1(r_data), .in2(alu_result), .select(MemtoReg), .out(mux4_out));		

endmodule
