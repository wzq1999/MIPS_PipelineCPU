`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:09 03/28/2020 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(
input clk,
input reset
    );
//if-id
wire [31:0]ins_mem_out;
//id-exe
wire doBranch_id;
wire shift_id;
wire wmem_id;
wire Mem2Reg_id;
wire sext_id;
wire [5:0]aluc_id;
wire aluimm_id;
wire wreg_id;
wire regrt_id;
wire [31:0]rsData_id;
wire [31:0]rtData_id;
wire [4:0]RdAddr_id;
wire [4:0]RtAddr_id;
wire [31:0]Imm_id;
wire [25:0]j_address_id;
wire [31:0]imm_for_branch_id;
//exe-mem
wire [31:0] ALUoutputData_ex;
wire [4:0] RegFileWtAddr_ex;
wire [31:0] rtData_ex;
wire wmem_ex;
wire Mem2Reg_ex;
wire wreg_ex;
//mem-wb	 
wire Mem2Reg_mem;
wire [31:0]memoryOutputData_mem;
wire [31:0]ALUoutputData_mem;
wire [4:0]RegFileWtAddr_mem;
wire wreg_mem;
//wb-id
wire [31:0]regWriteBackData_wb;
wire [4:0]RegFileWtAddr_wb;
wire wreg_wb;


wire [31:0] pc;
if_stage if_s (
    .clk(clk), 
	 .stall(stall),
    .reset(reset), 
    .branch_or_not(doBranch_id), 
    .branch_addr(imm_for_branch_id), 
    .ins_mem_out(ins_mem_out),
	 .pc(pc)
    );
id_stage id (
.pc(pc),
    .clk(clk), 
    .reset(reset), 
    .inst(ins_mem_out), 
    .reg_file_L_S(wreg_wb), 
    .write_addr(RegFileWtAddr_wb), 
    .write_data(regWriteBackData_wb),
	 .wreg_ex(wreg_ex), 
    .wreg_mem(wreg_mem), 
    .RegFileWtAddr_ex(RegFileWtAddr_ex), 
    .RegFileWtAddr_mem(RegFileWtAddr_mem), 	 
	 .Mem2Reg_ex(Mem2Reg_ex),
	 .Mem2Reg_mem(Mem2Reg_mem), 
	 .ALUoutputData_ex(ALUoutputData_ex), 
    .ALUoutputData_mem(ALUoutputData_mem), 
    .memoryOutputData_mem(memoryOutputData_mem), 
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
    .RtAddr(RtAddr_id), 
	 .imm_for_branch(imm_for_branch_id),
	 .stall(stall)
    );

ex_stage ex (
    .clk(clk), 
	 .reset(reset),
    .Cu_branch(branch_id), 
    .Cu_shift(shift_id), 
    .Cu_wmem(wmem_id), 
    .Cu_Mem2Reg(Mem2Reg_id), 
    .Cu_sext(sext_id), 
    .Cu_aluc(aluc_id), 
    .Cu_aluimm(aluimm_id), 
    .Cu_wreg(wreg_id), 
    .Cu_regrt(regrt_id), 
    .rsData(rsData_id), 
    .rtData(rtData_id), 
    .RtAddr_id(RtAddr_id), 
    .RdAddr_id(RdAddr_id), 
    .Imm_id(Imm_id), 
    .j_address(j_address_id), 
    .ALUoutputData_ex(ALUoutputData_ex), 
    .RegFileWtAddr_ex(RegFileWtAddr_ex), 
    .rtData_ex(rtData_ex), 
    .wmem_ex(wmem_ex), 
	 .wreg_ex(wreg_ex), 
    .Mem2Reg_ex(Mem2Reg_ex)
    );

mem_stage mem (
    .clk(clk),  //-------------------------------in
    .rst(reset), 
    .dataToSave(rtData_ex),
    .ALUoutputData_ex(ALUoutputData_ex), 
    .wmem_ex(wmem_ex), 
	 .wreg_ex(wreg_ex),
    .Mem2Reg_ex(Mem2Reg_ex), 
    .RegFileWtAddr_ex(RegFileWtAddr_ex), 
    .memoryOutputData_mem(memoryOutputData_mem), //--------------------out
    .ALUoutputData_mem(ALUoutputData_mem), 
    .Mem2Reg_mem(Mem2Reg_mem), 
	 .wreg_mem(wreg_mem),
    .RegFileWtAddr_mem(RegFileWtAddr_mem)
    );


wb_stage wb (
    .clk(clk),  //-------------------------------in
    .Mem2Reg_mem(Mem2Reg_mem), 
	 .wreg_mem(wreg_mem),
    .memoryOutputData_mem(memoryOutputData_mem), 
    .ALUoutputData_mem(ALUoutputData_mem), 
    .RegFileWtAddr_mem(RegFileWtAddr_mem), 
    .regWriteBackData_wb(regWriteBackData_wb), //--------------------out
	 .wreg_wb(wreg_wb),
    .RegFileWtAddr_wb(RegFileWtAddr_wb)
    );
endmodule
