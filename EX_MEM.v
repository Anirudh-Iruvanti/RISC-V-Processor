`timescale 1ns / 1ps

//do=decode stage output (which is execute stage input)
//eo=execute stage output

module EX_MEM(
input  [31:0] PC_plus_4_do,          //PC+4 input to  EX/MEM
input  [4:0] Read_data2_do,          //5 bit source reg  2 input field to EX/MEM
input [31:0] ALU_result,                 //32 bit ALU result input to EX/MEM
input  [4:0] Rd_do,                         //5 bit dest  field to EX/MEM 
//input  [4:0] Rs1_do,                       //5 bit source reg  1 input field to EX/MEM
//input  [4:0] Rs2_do,                       //5 bit source reg  2 input field to EX/MEM

//Control signal inputs

input  [1:0] Wr_data_sel_do,
input  Reg_wr_do,
input  Mem_rd_do,
input  Mem_wr_do,


input clk,
input reset,

output reg [31:0] PC_plus_4_eo,          //PC+4 output from  EX/MEM
output reg  [31:0] Read_data2_eo,          //32 bit read data output field from EX/MEM
output reg [31:0] ALU_result_eo,                 //32 bit ALU result output from  EX/MEM
output reg  [4:0] Rd_eo,                         //5 bit dest  field output EX/MEM
//output reg  [4:0] Rs1_eo,                       //5 bit source reg  1 output field from EX/MEM
//output reg  [4:0] Rs2_eo,                       //5 bit source reg  2 output field from EX/MEM

//Control signal outputs

output reg  [1:0] Wr_data_sel_eo,
output reg  Reg_wr_eo,
output reg  Mem_rd_eo,
output reg  Mem_wr_eo



    );
    
    always @(posedge clk, negedge reset)
    begin
    if(reset==0)
    begin
   
//    Wr_data_sel_eo<=0;
//    Reg_wr_eo<=0;
//    Mem_rd_eo<=0;
//    Mem_wr_eo<=0;
//    Rd_eo<=0;
    ALU_result_eo<=0;
    
    end
    else
    begin
    
    
    Wr_data_sel_eo<=Wr_data_sel_do;
    Reg_wr_eo<=Reg_wr_do;
    Mem_rd_eo<=Mem_rd_do;
    Mem_wr_eo<=Mem_wr_do;
    Rd_eo<=Rd_do;
    ALU_result_eo<=ALU_result;
    PC_plus_4_eo<=PC_plus_4_do;
    Read_data2_eo<=Read_data2_do;
    //Rs1_eo<=Rs1_do;
    //Rs2_eo<=Rs2_do;
    end
    end
endmodule