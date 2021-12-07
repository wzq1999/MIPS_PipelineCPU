`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:32:24 03/29/2020 
// Design Name: 
// Module Name:    wb_stage 
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
module wb_stage(
input clk,
input wreg_mem,
input Mem2Reg_mem,//1為從mem到reg, 0為alu輸出到reg
input [31:0]memoryOutputData_mem,
input [31:0]ALUoutputData_mem,
input [31:0]RegFileWtAddr_mem,
output reg [31:0]regWriteBackData_wb,
output wreg_wb,
output [31:0]RegFileWtAddr_wb
    );
reg [31:0]regWriteBackData_wb_this;
//不再延遲一周期，直接對regFile進行操作
always@(*)begin
	if(Mem2Reg_mem)
	regWriteBackData_wb<=memoryOutputData_mem;
	else
	regWriteBackData_wb<=ALUoutputData_mem;
end

assign	RegFileWtAddr_wb=RegFileWtAddr_mem;
assign	wreg_wb=wreg_mem;
endmodule
