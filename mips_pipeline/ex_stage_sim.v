`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:43:48 03/30/2020
// Design Name:   ex_stage
// Module Name:   D:/ise/arc_lab/lab1/ex_stage_sim.v
// Project Name:  lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ex_stage
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ex_stage_sim;

	// Inputs
	reg clk;
	reg Cu_branch;
	reg Cu_shift;
	reg Cu_wmem;
	reg Cu_Mem2Reg;
	reg Cu_sext;
	reg [5:0] Cu_aluc;
	reg Cu_aluimm;
	reg Cu_wreg;
	reg Cu_regrt;
	reg rsData;
	reg rtData;
	reg [4:0] RtAddr_id;
	reg [4:0] RdAddr_id;
	reg [31:0] Imm_id;
	reg [25:0] j_address;

	// Outputs
	wire [31:0] ALUoutputData_ex;
	wire [31:0] RegFileWtAddr_ex;
	wire [31:0] rtData_ex;
	wire wmem_ex;
	wire Mem2Reg_ex;
	wire ALUinputB;

	// Instantiate the Unit Under Test (UUT)
	ex_stage uut (
		.clk(clk), 
		.Cu_branch(Cu_branch), 
		.Cu_shift(Cu_shift), 
		.Cu_wmem(Cu_wmem), 
		.Cu_Mem2Reg(Cu_Mem2Reg), 
		.Cu_sext(Cu_sext), 
		.Cu_aluc(Cu_aluc), 
		.Cu_aluimm(Cu_aluimm), 
		.Cu_wreg(Cu_wreg), 
		.Cu_regrt(Cu_regrt), 
		.rsData(rsData), 
		.rtData(rtData), 
		.RtAddr_id(RtAddr_id), 
		.RdAddr_id(RdAddr_id), 
		.Imm_id(Imm_id), 
		.j_address(j_address), 
		.ALUoutputData_ex(ALUoutputData_ex), 
		.RegFileWtAddr_ex(RegFileWtAddr_ex), 
		.rtData_ex(rtData_ex), 
		.wmem_ex(wmem_ex), 
		.Mem2Reg_ex(Mem2Reg_ex), 
		.ALUinputB(ALUinputB)
	);

	initial begin
		// Initialize Inputs
		
		Cu_branch = 0;
		Cu_shift = 0;
		Cu_wmem = 0;
		Cu_Mem2Reg = 0;
		Cu_sext = 0;
		Cu_aluc = 0;
		Cu_aluimm = 0;
		Cu_wreg = 0;
		Cu_regrt = 0;
		rsData = 0;
		rtData = 0;
		RtAddr_id = 0;
		RdAddr_id = 0;
		Imm_id = 0;
		j_address = 0;

		// Wait 100 ns for global reset to finish
		#100;
        Cu_wmem = 1;
		  #20;
		// Add stimulus here

	end
        initial forever begin
		clk=0;#5;
		clk=1;#5;
	end
endmodule

