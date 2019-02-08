`timescale 1ns / 1ps

module Main_control_unit(
input Prediction_fo,
input Outcome,
input [31:0] Instruction_code_mcu,
input clk,
input reset,
//output Imm_Sel,
//output [1:0] PC_src,
output reg [1:0] PC_src,
output ALU_src,
output [1:0] Wr_data_sel,
output Reg_wr,
output Mem_rd,
output Mem_wr,
output [1:0] ALU_op,
output reg Flush
    );

wire [6:0] opcode;
assign opcode=Instruction_code_mcu[6:0];
reg [9:0] Ctrl_data;

always @(opcode)
begin
casex(opcode) 
//default: Ctrl_data<=10'bxxxxxxxxx;
7'b0000000:Ctrl_data<=10'b0000000000;//default/initial case
7'b0110011:Ctrl_data<=10'b0000010010;//R-type
7'b0000011:Ctrl_data<=10'b0011011000;//lw
7'b0100011:Ctrl_data<=10'b001xx00100;//sw
7'b1101111:Ctrl_data<=10'b0110110010;//jal
7'b0010011:Ctrl_data<=10'b0010010000;//addi
7'b1100011:Ctrl_data<=10'b10xxx0xxxx;   //branch


endcase
end    

//assign Imm_Sel=Ctrl_data[10];
//assign PC_src=Ctrl_data[9:8];
assign ALU_src=Ctrl_data[7];
assign Wr_data_sel=Ctrl_data[6:5];
assign Reg_wr=Ctrl_data[4];
assign Mem_rd=Ctrl_data[3];
assign Mem_wr=Ctrl_data[2];
assign ALU_op=Ctrl_data[1:0];


always @(Prediction_fo,Outcome)
begin

if (Prediction_fo ==0 && Outcome==0)
begin
PC_src<=2'b00;
Flush<=1'b0;
end
else if (Prediction_fo ==0 && Outcome==1)
begin
PC_src<=2'b11;
Flush<=1'b1;
end
else if (Prediction_fo ==1 && Outcome==0)
begin
PC_src<=2'b10;
Flush<=1'b0;
//Flush<=1'b1;
end
else if (Prediction_fo ==1 && Outcome==1)
begin
PC_src<=2'b00;
Flush<=1'b0;
end
end
///////////////////////////////////////////////////////////////////////////////////////////////////////////
always @(opcode)
begin
if (opcode==7'b0110011||opcode==7'b0000011||opcode==7'b0100011||opcode==7'b0010011||opcode==7'b0000000)
begin
PC_src<=2'b00;
Flush<=1'b0;
end
else if (opcode==7'b1101111)
begin
PC_src<=2'b01;
Flush<=1'b0;
end

if(reset==0)
begin
PC_src<=2'b00;
Flush<=1'b0;
end

end

endmodule
