`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:23 03/28/2020 
// Design Name: 
// Module Name:    if_stage 
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
module if_stage(input clk,
input reset,
input branch_or_not,//branch=1, else=0
input [31:0]branch_addr,
input stall,
output reg[31:0] pc,
output reg[31:0] ins_mem_out
    );
wire [31:0] ins_mem_out_this;

//設定reset
//pc寄存器 放此周期要執行的pc值，計算下個週期要執行的pc值
always@(posedge clk ) begin
	if(reset) begin pc<=0;ins_mem_out<=0;end
	else begin
		 if(stall) pc<=pc;
		else if(branch_or_not) pc<=branch_addr;
		else pc<=pc+4;
		ins_mem_out<=ins_mem_out_this;
	end
end

//instruction memory用rom_d
instruction_mem2	ins_mem ( .clka(~clk), //存储器时钟
  		.addra(pc[11:2]), 		// pc表示address
 		.douta(ins_mem_out_this) 		// ROM输出
	             );
endmodule
