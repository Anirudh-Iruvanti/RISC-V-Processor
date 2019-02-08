`timescale 1ns / 1ps

module Forwarding(

input [31:0] Instruction_code_fo,

input  [4:0] Rd_mo,                //5 bit dest reg from MEM/WB
input  [4:0] Rs1_do,               //5 bit source reg  1 input field to forwarding unit from ID/EX
input  [4:0] Rs2_do,               //5 bit source reg  2 input field to forwarding unit from ID/EX
input  [4:0] Rs1_fo,               //5 bit source reg  1 input field to forwarding unit from IF/ID
input  [4:0] Rs2_fo,               //5 bit source reg  2 input field to forwarding unit from IF/ID
input [4:0] Rd_eo,                  //5 bit dest reg  2 input field to forwarding unit from EX/MEM
input Reg_wr_eo,                  //Reg Write input from EX/MEM
input Reg_wr_mo,                 //Reg Write input from MEM/WB


output reg [1:0]  Fw_A,                   //Mux select line to forward first ALU operand
output reg [1:0] Fw_B,                    //Mux select line to forward second ALU operand
output reg Fw_P,                   //Mux select line to forward first Comparator operand
output reg Fw_Q                   //Mux select line to forward second Comparator operand
    );
    
  
wire [6:0] opcode;
assign opcode= Instruction_code_fo[6:0];
    
always @(Reg_wr_mo,Rd_mo,Reg_wr_eo,Rd_eo,Rs1_do)
begin
if(Reg_wr_eo==1 && Rd_eo!=0 && Rd_eo ==Rs1_do)
begin
Fw_A<=01;                           
end
else if(Reg_wr_mo==1 && Rd_mo!=0 && Rd_mo ==Rs1_do )
begin
Fw_A<=10;                           
end
else
begin
Fw_A<=00;
end
end   
    
////////////////////////////////////////// load followed by arithmetic, stall followed by forward 
always @(Reg_wr_mo,Rd_mo,Reg_wr_eo,Rd_eo,Rs2_do)
begin
if(Reg_wr_eo==1 && Rd_eo!=0 && Rd_eo ==Rs2_do)
begin
Fw_B<=01;                           
end
else if(Reg_wr_mo==1 && Rd_mo!=0 && Rd_mo ==Rs2_do )
begin
Fw_B<=10;                           
end
else
begin
Fw_B<=00;
end
end   

////////////////////////////////////////// arithmetic followed by arithmetic followed by branch

always @(Rs2_do,Rs1_fo,opcode)
begin
//if(opcode==7'b1100011)&&(Rs2_do ==Rs1_fo))
if((opcode==7'b1100011)&&(Rs1_fo==Rs2_do))
begin
Fw_P<=1;                           
end
else
begin
Fw_P<=0;
end
end   


always @(Rs2_do,Rs2_fo,opcode)
begin
//if(Rs2_do ==Rs2_fo)
if((opcode==7'b1100011)&&(Rs2_fo==Rs2_do))
begin
Fw_Q<=1;                          
end
else
begin
Fw_Q<=0;
end
end   

/////////////////////////////////////////////////////////// arithmetic followed by one instr followed by arithmetic
//always @(Rs2_do,Rs2_fo,opcode)
//begin
//if(Rs2_do ==Rs2_fo)
////if((opcode==7'b1100011)&&(Rs2_fo==Rs2_do))
//begin
//Fw_Q<=1;                          
//end
//else
//begin
//Fw_Q<=0;
//end
//end   


endmodule