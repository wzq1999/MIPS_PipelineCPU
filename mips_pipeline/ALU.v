`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:23:54 03/29/2020 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
input reset,
input[31:0] inputA,
input[31:0] inputB,
input[5:0] aluc,
output reg[31:0] ALUoutputData
    );
//×Ô¶¨ÁxµÄALU function code
parameter ADDfunc=6'b100000;
parameter ANDfunc=6'b100100;
parameter XORfunc=6'b100110;
parameter ORfunc=6'b100101;
parameter NORfunc=6'b100111;
parameter SUBfunc=6'b100010;
parameter SLTfunc=6'b000111;//new
parameter SRLfunc=6'b000000;

always@(*)begin
if(reset)
ALUoutputData<=32'b0;
else begin
case(aluc)
ADDfunc:ALUoutputData<= inputA+inputB;
ANDfunc:ALUoutputData<= inputA&inputB;
XORfunc: ALUoutputData<= inputA^inputB;
ORfunc: ALUoutputData<= inputA|inputB;
NORfunc: ALUoutputData<= ~(inputA|inputB);
SUBfunc: ALUoutputData<= inputA-inputB;
SLTfunc:ALUoutputData<= (inputA<inputB)?1:0;
SRLfunc:ALUoutputData<= inputB>>inputA;
default: ALUoutputData<= 32'b0;
endcase
end
end
endmodule
