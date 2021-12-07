`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:39:31 03/29/2020 
// Design Name: 
// Module Name:    ex_stage 
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
module ex_stage(
input reset,
input clk,
input Cu_branch,
input Cu_shift,
input Cu_wmem,
input Cu_Mem2Reg,
input Cu_sext,
input[5:0] Cu_aluc,
input Cu_aluimm,//��������
input Cu_wreg,
input Cu_regrt,//1��rt, 0��rd

input [31:0]rsData,//register file��ݔ��A
input [31:0]rtData,//register file��ݔ��B
input[4:0] RtAddr_id,//rt
input[4:0] RdAddr_id,//rd
input[31:0] Imm_id,//������չ
input[25:0] j_address,
output reg[31:0] ALUoutputData_ex,
output reg[4:0] RegFileWtAddr_ex,
output reg[31:0] rtData_ex,//mem�A�ε�data input
output reg wmem_ex,
output reg wreg_ex,
output reg Mem2Reg_ex
    );
reg[31:0] ALUinputB;
wire [31:0]ALUoutputData_ex_now;
reg[4:0] RegFileWtAddr_ex_now;
//���x�����Q��alu�ĵڶ���input
//alu�ăɂ�ݔ�������rs+rt(����add) Ҳ������rs+imm(����sw)
always@(*)begin
if(reset)
ALUinputB<=0;
	else if(Cu_aluimm)
	ALUinputB<=Imm_id;
	else
	ALUinputB<=rtData;
end

//���x�����Q���Ĵ����ѵ�ַ
always@(*)begin
if(reset)
RegFileWtAddr_ex_now<=0;
	else if(Cu_regrt)//1��rt, 0��rd
	RegFileWtAddr_ex_now<=RtAddr_id;
	else
	RegFileWtAddr_ex_now<=RdAddr_id;
end
//������һ�A�Ε��^�mʹ�õ��Ĕ���
always@(posedge clk)begin
if(reset)begin
ALUoutputData_ex<=0;
	rtData_ex<=0;
	wmem_ex<=0;
	wreg_ex<=0;
	Mem2Reg_ex<=0;
	RegFileWtAddr_ex<=0;
end
else begin
	ALUoutputData_ex<=ALUoutputData_ex_now;
	rtData_ex<=rtData;
	wmem_ex<=Cu_wmem;
	//Imm_ex<=Imm_id;
	wreg_ex<=Cu_wreg;
	Mem2Reg_ex<=Cu_Mem2Reg;
	RegFileWtAddr_ex<=RegFileWtAddr_ex_now;
	end
end
ALU alu (
	 .reset(reset),
    .inputA(rsData), 
    .inputB(ALUinputB), 
    .aluc(Cu_aluc), 
    .ALUoutputData(ALUoutputData_ex_now)
    );


endmodule
