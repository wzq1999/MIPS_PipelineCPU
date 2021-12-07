`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:42:26 03/28/2020 
// Design Name: 
// Module Name:    CtrlUnit 
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
module CtrlUnit(
input reset,
input[31:0] inst,
input wreg_ex,
input wreg_mem,
input[4:0] RegFileWtAddr_ex,
input[4:0] RegFileWtAddr_mem,
input Mem2Reg_ex,
input Mem2Reg_mem,
output Cu_branch,//1為branch, 0為否
output Cu_shift,//-------------------------------------------------------------todo
output Cu_wmem,//1為要write memory
output Cu_Mem2Reg,//1為從mem到reg, 0為alu輸出到reg
output Cu_sext,//1為立即數有位擴展-------------------------------------------------------------todo
output reg[5:0] Cu_aluc,//alu op
output Cu_aluimm,//有立即數
output Cu_wreg,//1為要寫reg
output Cu_regrt,//1為rt, 0為rd
output[25:0] j_address,
output wire stall,
output _ex_aluout_rs,
output _mem_aluout_rs,
output _mem_memdata_rs,
output _ex_aluout_rt,
output _mem_aluout_rt,
output _mem_memdata_rt

    );
wire[5:0] op;
wire[4:0] rs;
wire[4:0] rt;
wire[4:0] rd;
wire[4:0] shamt;
wire[5:0] funct;
wire[15:0] immediate;
assign op=inst[31:26];//op字段
assign rs=inst[25:21];//rs字段
assign rt=inst[20:16];//rt字段
assign rd=inst[15:11];
assign shamt=inst[10:6];
assign funct=(inst[5:0]==6'b001000)?ADDfunc:inst[5:0];//如果是jalr要add
assign immediate=inst[15:0];
assign j_address=inst[25:0];

//R-type指令，同時作為自定義的ALU function code
parameter r_op=6'b000000;
parameter ADDfunc=6'b100000;
parameter ANDfunc=6'b100100;
parameter XORfunc=6'b100110;
parameter ORfunc=6'b100101;
parameter NORfunc=6'b100111;
parameter SUBfunc=6'b100010;
parameter SLTfunc=6'b000111;//new
parameter SRLfunc=6'b000000;
assign Cu_regrt=(op!=r_op);

//I-type 指令
//sw、lw
parameter SW_op=6'b101011;
parameter LW_op=6'b100011;
assign Cu_wmem=(op==SW_op);
assign Cu_Mem2Reg=(op==LW_op);

parameter ADDI_op=6'b001000;
parameter ANDI_op=6'b001100;
parameter XORI_op=6'b001110;
parameter ORI_op=6'b001101;
//new
parameter LUI_op=6'b001111;
parameter SLTI_op=6'b001010;




assign Cu_aluimm=(op==SW_op||op==LW_op||op==ADDI_op||op==ANDI_op||op==XORI_op||op==ORI_op|| op==SLTI_op||op==LUI_op);//i-type
assign Cu_wreg=(op==LW_op||op==ADDI_op||op==ANDI_op||op==XORI_op||op==ORI_op||op==r_op);//r+i-type除了sw

//Branch指令
parameter BEQ_op=6'b000100;
parameter BNE_op=6'b000101;
parameter J_op=6'b000010;//new
parameter JAL_op=6'b000011;
assign Cu_branch=(op==BEQ_op||op==BNE_op||op==J_op||op==JAL_op);


always@(*)begin
if(reset)
	Cu_aluc<=6'b000000;
case(op)
	r_op:Cu_aluc<=funct;
	BEQ_op:  Cu_aluc<=SUBfunc;
	BNE_op:  Cu_aluc<=SUBfunc;
	ADDI_op:  Cu_aluc<=ADDfunc;
	ANDI_op:  Cu_aluc<=ANDfunc;
	XORI_op:  Cu_aluc<=XORfunc;
	ORI_op:  Cu_aluc<=ORfunc;
	SW_op:  Cu_aluc<=ADDfunc;
	LW_op:  Cu_aluc<=ADDfunc;
	SLTI_op:Cu_aluc<=SLTfunc;//new
	J_op:Cu_aluc<=ADDfunc;
	LUI_op:Cu_aluc<=ADDfunc;
	
	default:  Cu_aluc<=ADDfunc;

endcase
end

wire ex_write_rs;
wire ex_write_rt;
wire mem_write_rs;
wire mem_write_rt;

//作為描述此時讀寫狀態的信號
assign ex_write_rs=wreg_ex&&(RegFileWtAddr_ex==rs);
assign ex_write_rt=wreg_ex&&(RegFileWtAddr_ex==rt);
assign mem_write_rs=wreg_mem&&(RegFileWtAddr_mem==rs);
assign mem_write_rt=wreg_mem&&(RegFileWtAddr_mem==rt);

//stall信號
assign stall=(ex_write_rs||ex_write_rt)&&Mem2Reg_ex;

//數據冒險信號，冒險來源階段_冒險來源部件_write_目標字段
assign _ex_aluout_rs=ex_write_rs&&!Mem2Reg_ex;
assign _mem_aluout_rs=mem_write_rs&&!Mem2Reg_mem;
assign _mem_memdata_rs=mem_write_rs&&Mem2Reg_mem;
assign _ex_aluout_rt=ex_write_rt&&!Mem2Reg_ex;
assign _mem_aluout_rt=mem_write_rt&&!Mem2Reg_mem;
assign _mem_memdata_rt=mem_write_rt&&Mem2Reg_mem;

endmodule
