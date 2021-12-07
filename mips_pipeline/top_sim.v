`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:09:19 03/30/2020
// Design Name:   top
// Module Name:   D:/ise/arc_lab/lab1/top_sim.v
// Project Name:  lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_sim;

	// Inputs
	reg clk;
	reg reset;
	
//outputs
wire [31:0]ins_mem_out=uut.ins_mem_out;
wire[31:0] if_pc=uut.if_s.pc;
//id-exe
wire doBranch_id=uut.doBranch_id;
//wire shift_id=uut.shift_id;
//wire wmem_id=uut.wmem_id;
wire Mem2Reg_id=uut.Mem2Reg_id;
//wire sext_id=uut.sext_id;
//wire [5:0]aluc_id=uut.aluc_id;
wire aluimm_id=uut.aluimm_id;
wire wreg_id=uut.wreg_id;
wire regrt_id=uut.regrt_id;
wire [31:0]rsData_id=uut.rsData_id;
wire [31:0]rtData_id=uut.rtData_id;
//in id
wire [4:0]id_RsAddr_id=uut.id.RsAddr;
wire [4:0]id_RtAddr_now_id=uut.id.RtAddr_now;
wire [4:0]id_rsDataFromReg=uut.id.rsDataFromReg;
wire [4:0]id_rtDataFromReg=uut.id.rtDataFromReg;
wire[4:0] write_addr_cur=uut.id.write_addr_cur;
wire [31:0] write_data_cur=uut.id. write_data_cur;
wire JAL=uut.id.JAL;
wire [4:0]RdAddr_id=uut.RdAddr_id;
wire [4:0]RtAddr_id=uut.RtAddr_id;
wire [31:0]Imm_id=uut.Imm_id;
wire [25:0]j_address_id=uut.j_address_id;
//wire [31:0]imm_for_branch_id=uut.imm_for_branch_id;
//wire [31:0]id_branch_addr=uut.id.branch_addr;


//stall signals
wire ctrlUnit_stall=uut.id.ctrlUnit.stall;
wire[4:0] ctrlUnit_RegFileWtAddr_ex=uut.id.ctrlUnit.RegFileWtAddr_ex;
wire[4:0] ctrlUnit_RegFileWtAddr_mem=uut.id.ctrlUnit.RegFileWtAddr_mem;
wire[4:0] ctrlUnit_rs=uut.id.ctrlUnit.rs;
wire[4:0] ctrlUnit_rt=uut.id.ctrlUnit.rt;
wire[4:0] ctrlUnit_ex_write_rs=uut.id.ctrlUnit.ex_write_rs;
wire[4:0] ctrlUnit_ex_write_rt=uut.id.ctrlUnit.ex_write_rt;
wire ctrlUnit_Mem2Reg_ex=uut.id.ctrlUnit.Mem2Reg_ex;
wire stall=uut.stall;
wire uut_Mem2Reg_ex=uut.Mem2Reg_ex;
//forward signals
wire _ex_aluout_rs=uut.id._ex_aluout_rs;
wire _mem_aluout_rs=uut.id._mem_aluout_rs;
wire _mem_memdata_rs=uut.id._mem_memdata_rs;
wire _ex_aluout_rt=uut.id._ex_aluout_rt;
wire _mem_aluout_rt=uut.id._mem_aluout_rt;
wire _mem_memdata_rt=uut.id._mem_memdata_rt;


//regsfiles
wire [31:0] regfile_1=uut.id.regFile.registers[1];
wire [31:0] regfile_2=uut.id.regFile.registers[2];
wire [31:0] regfile_3=uut.id.regFile.registers[3];
wire [31:0] regfile_4=uut.id.regFile.registers[4];
wire [31:0] regfile_5=uut.id.regFile.registers[5];
wire [31:0] regfile_6=uut.id.regFile.registers[6];
wire [31:0] regfile_7=uut.id.regFile.registers[7];
wire [31:0] regfile_8=uut.id.regFile.registers[8];
wire [31:0] regfile_9=uut.id.regFile.registers[9];
wire [31:0] regfile_10=uut.id.regFile.registers[10];
wire [31:0] regfile_31=uut.id.regFile.registers[31];
wire [31:0] regfile_write_data=uut.id.regFile.write_data;
//ex-stage

//exe-mem
wire [31:0] ALUoutputData_ex=uut.ALUoutputData_ex;
wire [4:0] RegFileWtAddr_ex=uut.RegFileWtAddr_ex;
wire [31:0] rtData_ex=uut.rtData_ex;
wire wmem_ex=uut.wmem_ex;
wire Mem2Reg_ex=uut.Mem2Reg_ex; 
wire wreg_ex=uut.wreg_ex;
//mem-wb	 
wire Mem2Reg_mem=uut.Mem2Reg_mem;
wire [31:0]memoryOutputData_mem=uut.memoryOutputData_mem;
wire [31:0]ALUoutputData_mem=uut.ALUoutputData_mem;
wire [4:0]RegFileWtAddr_mem=uut.RegFileWtAddr_mem;
wire wreg_mem=uut.wreg_mem;
//wb-id
wire [31:0]regWriteBackData_wb=uut.regWriteBackData_wb;
wire [4:0]RegFileWtAddr_wb=uut.RegFileWtAddr_wb;
wire wreg_wb=uut.wreg_wb;
	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        reset=1;
		  #10;
		  reset=0;
		  force uut.imm_for_branch_id=0;
release uut.imm_for_branch_id;		
force uut.ins_mem_out=0;
release uut.ins_mem_out;	
		  #20;
		// Add stimulus here

force uut.id.regFile.registers[1]=1;
force uut.id.regFile.registers[2]=2;
force uut.id.regFile.registers[3]=3;
force uut.id.regFile.registers[4]=4;
force uut.id.regFile.registers[5]=5;
force uut.id.regFile.registers[6]=6;
force uut.id.regFile.registers[7]=7;
force uut.id.regFile.registers[8]=8;
force uut.id.regFile.registers[9]=9;
force uut.id.regFile.registers[10]=10;
release uut.id.regFile.registers[1];
release uut.id.regFile.registers[2];
release uut.id.regFile.registers[3];
release uut.id.regFile.registers[4];
release uut.id.regFile.registers[5];
release uut.id.regFile.registers[6];
release uut.id.regFile.registers[7];
release uut.id.regFile.registers[8];
release uut.id.regFile.registers[9];
release uut.id.regFile.registers[10];
	end
   initial forever begin
		clk=0;#5;
		clk=1;#5;
	end   
endmodule

