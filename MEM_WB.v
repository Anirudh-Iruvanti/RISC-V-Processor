`timescale 1ns / 1ps

//eo=execute stage output (which is MEM stage input)
//mo=MEM stage output

module MEM_WB(

input [31:0] PC_plus_4_eo,                 //PC+4 input to  MEM/WB
input [31:0] Read_data_dm,                 //Read data input to data mem
input [31:0] ALU_result_eo,                 //32 bit ALU result to MEM/WB
input [4:0] Rd_eo,                                //5 bit dest  field to MEM/WB

//input  [4:0] Rs1_eo,                            //5 bit source reg  1 input field to MEM/WB
//input  [4:0] Rs2_eo,                            //5 bit source reg  2 input field to MEM/WB

//Control signal inputs

input [1:0] Wr_data_sel_eo,
input Reg_wr_eo,


input clk,
input reset,

output reg [31:0] PC_plus_4_mo,                 //PC+4 output from  MEM/WB
output reg [31:0] Read_data_dm_mo,                 //Read data output from data mem
output reg [31:0] ALU_result_mo,                 //32 bit ALU result output from MEM/WB
output reg [4:0] Rd_mo,                                //5 bit dest  field output from MEM/WB

//Control signal outputs

output reg [1:0] Wr_data_sel_mo,
output reg Reg_wr_mo
 );
    
    always @(posedge clk, negedge reset)
    begin
    if(reset==0)
    begin
   
//    Wr_data_sel_mo<=0;
//    Reg_wr_mo<=0;
//    Rd_mo<=0;
    ALU_result_mo<=0;
    Read_data_dm_mo<=0;
    
    end
    else
    begin
    
    
    Wr_data_sel_mo<=Wr_data_sel_eo;
    Reg_wr_mo<=Reg_wr_eo;
 
    Read_data_dm_mo<=Read_data_dm;
    Rd_mo<=Rd_eo;
    ALU_result_mo<=ALU_result_eo;
    PC_plus_4_mo<=PC_plus_4_eo;
    

    //Rs1_eo<=Rs1_do;
    //Rs2_eo<=Rs2_do;
    end
    end
endmodule