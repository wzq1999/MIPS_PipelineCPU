`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:20:07 06/24/2020
// Design Name:   id_stage
// Module Name:   D:/ise/arc_lab/lab3_new/lab3/id_sim.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: id_stage
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module id_sim;

	// Inputs
	reg clk;
	reg reset;
	reg [31:0] inst;
	reg reg_file_L_S;
	reg [4:0] write_addr;
	reg [31:0] write_data;
	reg wreg_ex;
	reg wreg_mem;
	reg [4:0] RegFileWtAddr_ex;
	reg [4:0] RegFileWtAddr_mem;
	reg [31:0] ALUoutputData_ex;
	reg [31:0] ALUoutputData_mem;
	reg [31:0] memoryOutputData_mem;
	reg Mem2Reg_ex;
	reg Mem2Reg_mem;

	// Outputs
	wire doBranch_id;
	wire shift_id;
	wire wmem_id;
	wire Mem2Reg_id;
	wire sext_id;
	wire [5:0] aluc_id;
	wire aluimm_id;
	wire wreg_id;
	wire regrt_id;
	wire [31:0] rsData_id;
	wire [31:0] rtData_id;
	wire [4:0] RdAddr_id;
	wire [31:0] Imm_id;
	wire [25:0] j_address_id;
	wire [4:0] RtAddr;
	wire [31:0] imm_for_branch;
	wire stall;

	// Instantiate the Unit Under Test (UUT)
	id_stage uut (
		.clk(clk), 
		.reset(reset), 
		.inst(inst), 
		.reg_file_L_S(reg_file_L_S), 
		.write_addr(write_addr), 
		.write_data(write_data), 
		.wreg_ex(wreg_ex), 
		.wreg_mem(wreg_mem), 
		.RegFileWtAddr_ex(RegFileWtAddr_ex), 
		.RegFileWtAddr_mem(RegFileWtAddr_mem), 
		.ALUoutputData_ex(ALUoutputData_ex), 
		.ALUoutputData_mem(ALUoutputData_mem), 
		.memoryOutputData_mem(memoryOutputData_mem), 
		.Mem2Reg_ex(Mem2Reg_ex), 
		.Mem2Reg_mem(Mem2Reg_mem), 
		.doBranch_id(doBranch_id), 
		.shift_id(shift_id), 
		.wmem_id(wmem_id), 
		.Mem2Reg_id(Mem2Reg_id), 
		.sext_id(sext_id), 
		.aluc_id(aluc_id), 
		.aluimm_id(aluimm_id), 
		.wreg_id(wreg_id), 
		.regrt_id(regrt_id), 
		.rsData_id(rsData_id), 
		.rtData_id(rtData_id), 
		.RdAddr_id(RdAddr_id), 
		.Imm_id(Imm_id), 
		.j_address_id(j_address_id), 
		.RtAddr(RtAddr), 
		.imm_for_branch(imm_for_branch), 
		.stall(stall)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		inst = 0;
		reg_file_L_S = 0;
		write_addr = 0;
		write_data = 0;
		wreg_ex = 0;
		wreg_mem = 0;
		RegFileWtAddr_ex = 0;
		RegFileWtAddr_mem = 0;
		ALUoutputData_ex = 0;
		ALUoutputData_mem = 0;
		memoryOutputData_mem = 0;
		Mem2Reg_ex = 0;
		Mem2Reg_mem = 0;

		// Wait 100 ns for global reset to finish
		#100;
       reset=1;#50;
		reset=0;#50 
		// Add stimulus here
inst=32'h08000008;#30;//j 0x000008	
inst=32'h10430010;#30;//beq $s2, $s3, 16	
inst=32'h0022482A;#40;//slt t1 at v0	
inst=32'h00015082;#40;//srl t2 at 0x0002

inst=32'h3C030003;#30;//lui v1 0x0003
inst=32'h00200008;#30;//jr at
inst=32'h0000F809;#40;//jalr ra zero
inst=32'h20240001;#40;//addi a0 at 0x0001
inst=32'h30450003;#40;//andi a1 v0 0x0003
inst=32'h14220000;#30;//bne at v0 0x0000
inst=32'h28480005;#40;//slti t0 v0 0x0005
inst=32'h0C000012;#30;//jal 0x000012
	end
     initial forever begin
		clk= 0;#5;
		clk= 1;#5;
		end    
endmodule

