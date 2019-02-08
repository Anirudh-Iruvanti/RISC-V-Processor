`timescale 1ns / 1ps


module ALU(
input [31:0] A,
input [31:0] B,
input [3:0] ALUcontrol,
//input [4:0] Shamt,
output reg Zero,
output reg [31:0] ALUresult
    );
    
    always@(A,B,ALUcontrol)
    begin
    case(ALUcontrol)
    4'b0010: ALUresult<= A+B;
    4'b0110: ALUresult<= A-B;
    4'b0000: ALUresult<= A&B;
    4'b0001: ALUresult<= A|B;
    4'b0111: ALUresult<= A^B;
    4'b0011:ALUresult<=A*B;
    4'b0100: ALUresult<=A<<B;
    4'b0101: ALUresult<=A>>B;
    endcase
    
            if (ALUresult==0)
            Zero=1;
            else
            Zero=0;
            end         
endmodule