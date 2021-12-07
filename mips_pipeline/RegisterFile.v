`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:41:04 03/28/2020 
// Design Name: 
// Module Name:    RegisterFile 
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
module RegisterFile(
input clk,
input reset,
input L_S,
input[4:0] read_addr_A,
input[4:0] read_addr_B,
input[4:0] write_addr,
input [31:0] write_data,
output [31:0] dataA,
output [31:0] dataB
    );
reg[31:0] registers[1:31];
integer i;
//initial registers
always@(posedge clk or posedge reset)begin
	if(reset==1)
	 // registers[0:31] <= #1 0;
		for(i=0;i<32;i=i+1)
		registers[i]<=0;
	else if(L_S)
	registers[write_addr]<=write_data;
end
//read

	assign dataA=read_addr_A==0? 32'b0:registers[read_addr_A];
	assign dataB=read_addr_B==0? 32'b0:registers[read_addr_B];

endmodule
