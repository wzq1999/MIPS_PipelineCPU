`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:36:17 03/29/2020
// Design Name:   CtrlUnit
// Module Name:   D:/ise/arc_lab/lab1/ctrlUnitSim.v
// Project Name:  lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CtrlUnit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ctrlUnitSim;

	// Inputs
	reg [31:0] inst;

	// Outputs
	wire Cu_branch;
	wire Cu_shift;
	wire Cu_wmem;
	wire Cu_Mem2Reg;
	wire Cu_sext;
	wire [5:0] Cu_aluc;
	wire Cu_aluimm;
	wire Cu_wreg;
	wire Cu_regrt;
	wire [25:0] j_address;

	// Instantiate the Unit Under Test (UUT)
	CtrlUnit uut (
		.inst(inst), 
		.Cu_branch(Cu_branch), 
		.Cu_shift(Cu_shift), 
		.Cu_wmem(Cu_wmem), 
		.Cu_Mem2Reg(Cu_Mem2Reg), 
		.Cu_sext(Cu_sext), 
		.Cu_aluc(Cu_aluc), 
		.Cu_aluimm(Cu_aluimm), 
		.Cu_wreg(Cu_wreg), 
		.Cu_regrt(Cu_regrt), 
		.j_address(j_address)
	);

	initial begin
		// Initialize Inputs
		inst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        inst =32'h8c010014;
		#20;
		inst=32'h8c020015;
		#20;
		// Add stimulus here

	end
      
endmodule

