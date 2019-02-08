`timescale 1ns / 1ps
//fi=fetch stage input
//fo=fetch stage output
module IF_ID(
input Prediction,
//input [31:0] PC,
input [31:0] Add_result2,
input IF_ID_ctrl,                                 //control from stalling unit
input [31:0] Instruction_code_fi,           //instruction code input to IF/ID
input [31:0] PC_plus_4_fi,                   //PC+4 input to  IF/ID
input clk,
input reset,
input Flush,                                  //flush input
output reg [31:0] PC_plus_4_fo,         //PC+4 output to  IF/ID
output reg [4:0] Rs1_fo,                           //5 bit source reg 1 field from IF/ID
output reg [4:0] Rs2_fo,                           //5 bit source reg 2 field from IF/ID
output reg [31:0] Instruction_code_fo,  //Instr_code for immediate data for sign extension input as output from IF/ID
output reg [4:0] Rd_fo,                            //5 bit dest reg field from IF/ID
output reg [2:0]  I_aluctrl_fn7_fo,               //3 bit concatenated fn7 I[31,30,25] 
output reg [2:0]  I_aluctrl_fn3_fo,                 //3 bit fn3 I[14,13,12] field from IF/ID
output reg Prediction_fo,
//output reg [31:0] PC_fo,
output reg [31:0] Add_result2_fo
 );
    

reg clk_stall;

always @(clk)
begin
if(IF_ID_ctrl==0)
clk_stall<=0;
else
clk_stall<=clk;
end



   always@ (negedge reset, negedge clk_stall)
   begin
   if ( reset==0)
               begin
               Rs1_fo<=0;
               Rs2_fo<=0;
               Rd_fo<=0;
               Instruction_code_fo<=0;
               I_aluctrl_fn7_fo<=0;
               I_aluctrl_fn3_fo<=0;
               end
   else
               begin  
               Rs1_fo<=Instruction_code_fi[19:15];
               Rs2_fo<=Instruction_code_fi[24:20];
               Rd_fo<=Instruction_code_fi[11:7];
               Instruction_code_fo<=Instruction_code_fi;
               I_aluctrl_fn7_fo<={Instruction_code_fi[31:30],Instruction_code_fi[25]};
               I_aluctrl_fn3_fo<=Instruction_code_fi[14:12];
               PC_plus_4_fo<=PC_plus_4_fi;
               Prediction_fo<=Prediction;
               //PC_fo<=PC;
               Add_result2_fo<=Add_result2;
               end
   end
   
   ///////////////////////////////////////////////////////////////////////////
   
///////////////////////////////////////////////////////////////////////////  
   always@(Flush)
   begin
   
   if(Flush==1)
   begin
   Rs1_fo<=5'b00000;
   Rs2_fo<=5'b00000;
   Rd_fo<=5'b00000;   
   Instruction_code_fo<=0;
   I_aluctrl_fn7_fo<=0;
   I_aluctrl_fn3_fo<=0;
   end
   
//   if(Flush==1)
//   begin
//   Rs1_fo<=5'b11111;
//   Rs2_fo<=5'b11111;
//   Rd_fo<=5'b11111;   
//   Instruction_code_fo<=1;
//   I_aluctrl_fn7_fo<=1;
//   I_aluctrl_fn3_fo<=1;
//   end
   
   else
   begin
   Rs1_fo<=Instruction_code_fi[19:15];
   Rs2_fo<=Instruction_code_fi[24:20];
   Rd_fo<=Instruction_code_fi[11:7];
   Instruction_code_fo<=Instruction_code_fi;
   I_aluctrl_fn7_fo<={Instruction_code_fi[31:30],Instruction_code_fi[25]};
   I_aluctrl_fn3_fo<=Instruction_code_fi[14:12];
   end
   
   end
  /////////////////////////////////////////////////////////////////////////////////// 
endmodule