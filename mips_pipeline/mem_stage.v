`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:43:02 03/29/2020 
// Design Name: 
// Module Name:    mem_stage 
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
module mem_stage(
input clk,
input rst,
input[31:0] dataToSave,//(rtData)
input [31:0] ALUoutputData_ex,//(address)
input wmem_ex,//1為有memory要寫
input wreg_ex,
input Mem2Reg_ex,
input [4:0]RegFileWtAddr_ex,
output reg[31:0] memoryOutputData_mem,
output reg [31:0]ALUoutputData_mem,
output reg wreg_mem,
output reg Mem2Reg_mem,
output reg [4:0]RegFileWtAddr_mem
    );
wire [31:0]memoryOutputData;
DataMemory datamemory(
		.clka(~clk),
		.addra(ALUoutputData_ex[11:2]),
		.douta(memoryOutputData),
		.wea(wmem_ex),
		.dina(dataToSave[31:0])
);
//保存下一階段會繼續使用到的數據
always@(posedge clk)begin
	memoryOutputData_mem<=memoryOutputData;
	ALUoutputData_mem<=ALUoutputData_ex;
	wreg_mem<=wreg_ex;
	Mem2Reg_mem<=Mem2Reg_ex;
	RegFileWtAddr_mem<=RegFileWtAddr_ex;
end
endmodule
