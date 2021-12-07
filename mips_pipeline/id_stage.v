`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:23:40 03/28/2020 
// Design Name: 
// Module Name:    id_stage 
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
module id_stage(
input[31:0] pc,
input clk,
input reset,
input [31:0]inst,
input reg_file_L_S,//Mem2Reg_wb
input [4:0]write_addr,//RegFileWtAddr_wb
input [31:0]write_data,//regWriteBackData_wb
input wreg_ex,
input wreg_mem,
//用來判斷是否要stall或冒險的信號，來自mem和ex階段
input[4:0] RegFileWtAddr_ex,
input[4:0] RegFileWtAddr_mem,
//冒險時提前取到的值
input [31:0]ALUoutputData_ex,
input [31:0]ALUoutputData_mem,
input [31:0]memoryOutputData_mem,
input Mem2Reg_ex,
input Mem2Reg_mem,
output reg doBranch_id,
output reg shift_id,
output reg wmem_id,
output reg Mem2Reg_id,
output reg sext_id,
output reg [5:0] aluc_id,
output reg aluimm_id,//有立即數
output reg wreg_id,
output reg regrt_id,//1為rt, 0為rd
output reg [31:0]rsData_id,//register file的輸出A
output reg [31:0]rtData_id,//register file的輸出B
output reg [4:0] RdAddr_id,//目的reg
output reg [31:0] Imm_id,//符号拓展
output reg [25:0] j_address_id,
output reg[4:0]RtAddr,
output [31:0]imm_for_branch,
output stall
    );
	 
//reg doBranch_id;
wire Cu_branch;
wire Cu_shift;
wire Cu_wmem;
wire Cu_Mem2Reg;
wire Cu_sext;
wire[5:0] Cu_aluc;
wire Cu_aluimm;//有立即數
wire Cu_wreg;
wire Cu_regrt;//1為rt, 0為rd
wire [31:0]rsDataFromReg;//register file的輸出A
reg [31:0]rsData;
wire [31:0]rtDataFromReg;//register file的輸出B
reg [31:0]rtData;
wire[4:0] RdAddr;//目的reg
wire[31:0] Imm;//符号拓展
wire[25:0] j_address;
wire[4:0] RsAddr;
wire [5:0]op;
assign op=inst[31:26];//op字段
reg[31:0]branch_addr;
assign imm_for_branch=branch_addr;//未經過1 clk延遲
reg[4:0] write_addr_cur;
reg [31:0] write_data_cur;
reg JAL;

wire _ex_aluout_rs;
wire _mem_aluout_rs;
wire _mem_memdata_rs;
wire _ex_aluout_rt;
wire _mem_aluout_rt;
wire _mem_memdata_rt;

//保存下一階段會繼續使用到的數據
always@(posedge clk)begin
if(reset||stall)begin
shift_id<=0;
wmem_id<=0;
sext_id<=0;
aluc_id<=0;
aluimm_id<=0;
wreg_id<=0;
regrt_id<=0;
rsData_id<=0;
rtData_id<=0;
RdAddr_id<=0;
RtAddr<=0;
Imm_id<=0;
j_address_id<=0;
Mem2Reg_id<=0;
//branch_addr<=0;
end
else if(JAL)begin
shift_id<=Cu_shift;
wmem_id<=1'b0;
sext_id<=Cu_sext;
aluc_id<=6'b100000;//add
aluimm_id<=1'b1;
wreg_id<=1'b1;
regrt_id<=1'b1;
rsData_id<=0;//a
rtData_id<=rtData;
RdAddr_id<=RdAddr;
RtAddr<=5'b11111;
Imm_id<=pc;//b
j_address_id<=j_address;
Mem2Reg_id<=1'b0;
end
else begin
shift_id<=Cu_shift;
wmem_id<=Cu_wmem;
sext_id<=Cu_sext;
aluc_id<=Cu_aluc;
aluimm_id<=Cu_aluimm;
wreg_id<=Cu_wreg;
regrt_id<=Cu_regrt;
rsData_id<=rsData;
rtData_id<=rtData;
RdAddr_id<=RdAddr;
RtAddr<=RtAddr_now;
Imm_id<=Imm;
j_address_id<=j_address;
Mem2Reg_id<=Cu_Mem2Reg;
end
end

wire [4:0]RtAddr_now;
assign RtAddr_now=inst[20:16];//rt
assign RdAddr=inst[15:11];//rd
assign Imm={{16{inst[15]}},inst[15:0]};//符号扩展成32位立即数
assign RsAddr=inst[25:21];//rs
CtrlUnit ctrlUnit (
	.reset(reset),
    .inst(inst), 
	 .wreg_ex(wreg_ex), 
    .wreg_mem(wreg_mem), 
    .RegFileWtAddr_ex(RegFileWtAddr_ex), 
    .RegFileWtAddr_mem(RegFileWtAddr_mem), 
	 .Mem2Reg_ex(Mem2Reg_ex),
	 .Mem2Reg_mem(Mem2Reg_mem), 
    .Cu_branch(Cu_branch), 
    .Cu_shift(Cu_shift), 
    .Cu_wmem(Cu_wmem), 
    .Cu_Mem2Reg(Cu_Mem2Reg), 
    .Cu_sext(Cu_sext), 
    .Cu_aluc(Cu_aluc), 
    .Cu_aluimm(Cu_aluimm), 
    .Cu_wreg(Cu_wreg), 
    .Cu_regrt(Cu_regrt),
	 .j_address(j_address),
	 .stall(stall),
	 ._ex_aluout_rs(_ex_aluout_rs), 
    ._mem_aluout_rs(_mem_aluout_rs), 
    ._mem_memdata_rs(_mem_memdata_rs), 
    ._ex_aluout_rt(_ex_aluout_rt), 
    ._mem_aluout_rt(_mem_aluout_rt), 
    ._mem_memdata_rt(_mem_memdata_rt)
    );
RegisterFile regFile (
    .clk(clk), 
    .reset(reset), 
    .L_S(reg_file_L_S || JAL), 
    .read_addr_A(RsAddr), 
    .read_addr_B(RtAddr_now), 
    .write_addr(write_addr_cur), 
    .write_data(write_data_cur), 
    .dataA(rsDataFromReg), 
    .dataB(rtDataFromReg)
    );
	 
always@(*)begin
if(reset)
JAL=0;
else if(Cu_branch&&op==JAL_op&&~stall)
	JAL=1;
else
	JAL=0;
end

	 
	 
	 
always @(*)begin
	if(reset)begin
	write_addr_cur=0;
	write_data_cur=0;end
	else begin
	write_addr_cur=write_addr;
	write_data_cur=write_data;end

/*	else if (~JAL)begin
	write_addr_cur=write_addr;
	write_data_cur=write_data;end
	else begin
	write_addr_cur=5'b11111;
	write_data_cur=pc;end*/
end

parameter BEQ_op=6'b000100;
parameter BNE_op=6'b000101;
parameter J_op=6'b000010;//new
parameter JAL_op=6'b000011;

always@(*)begin

if(Cu_branch)
	case(op)
	BEQ_op:begin 
	doBranch_id=(rsData==rtData)?1'b1:1'b0;
	branch_addr=Imm;
	end
	BNE_op:begin 
	doBranch_id=(rsData!=rtData)?1'b1:1'b0;
	branch_addr=Imm;
	end
	J_op:begin
	doBranch_id=1'b1;
	branch_addr={16'b0, inst[15:0]};
	end
	JAL_op:begin
	doBranch_id=1'b1;
	branch_addr={16'b0, inst[15:0]};
	end
	endcase

else begin
	doBranch_id=1'b0;
	branch_addr=32'b0;
	end
	
end

always@(*)begin//rs data hazard
	if(reset)
	rsData=0;

	else if (_ex_aluout_rs)
	 rsData=ALUoutputData_ex;
	else if(_mem_aluout_rs)
	 rsData=ALUoutputData_mem;
	else if(_mem_memdata_rs)
	 rsData=memoryOutputData_mem;
	else
	 rsData=rsDataFromReg;
end
always@(*)begin//rt data hazard
	if(reset)
	rtData<=0;
	if (_ex_aluout_rt)
	 rtData<=ALUoutputData_ex;
	else if(_mem_aluout_rt)
	 rtData<=ALUoutputData_mem;
	else if(_mem_memdata_rt)
	 rtData<=memoryOutputData_mem;
	else
	 rtData<=rtDataFromReg;
end

endmodule
