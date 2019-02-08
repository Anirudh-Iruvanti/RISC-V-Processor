`timescale 1ns / 1ps
//fo=fetch stage output (which is decode stage input)
//do=decode stage output

module ID_EX(
input  [31:0] PC_plus_4_fo,              //PC+4 input to  ID/EX
input  [4:0] Rs1_fo,              //5 bit source reg  1 input field to ID/EX
input  [4:0] Rs2_fo,              //5 bit source reg  2 input field to ID/EX
input  [31:0] Read_data1_fo,           //32 bit Read_data1
input  [31:0] Read_data2_fo,           //32 bit Read_data2
input [31:0] Sign_ext,                       // sign extension input to ID/EX
input  [4:0] Rd_fo,                            //5 bit dest  field to ID/EX
input  [2:0]  I_aluctrl_fn7_fo,                   //3 bit concatenated fn7 I[31,30,25]  field to ID/EX
input  [2:0]  I_aluctrl_fn3_fo,                 //3 bit fn3 I[14,13,12] field to ID/EX

//Control signal inputs


input ALU_src,
input [1:0] Wr_data_sel,
input Reg_wr,
input Mem_rd,
input Mem_wr,
input [1:0] ALU_op,

input clk,
input reset,

output reg [31:0] PC_plus_4_do,          //PC+4 output from  ID/EX
output reg [31:0] Read_data1_do,          //32 bit read data  1 output field from ID/EX
output reg [31:0] Read_data2_do,          //32 bit read data  2 output field from ID/EX
output reg [31:0] Sign_ext_do,               // sign extension output from ID/EX
output reg [4:0] Rd_do,                         //5 bit dest  field from ID/EX
output reg [2:0]  I_aluctrl_fn7_do,                   //3 bit concatenated fn7 I[31,30,25]  field from ID/EX
output reg [2:0]  I_aluctrl_fn3_do,                 //3 bit fn3 I[14,13,12] field from ID/EX
output  reg [4:0] Rs1_do,              //5 bit source reg  1 output field from ID/EX
output  reg [4:0] Rs2_do,              //5 bit source reg  2 output field from ID/EX

//Control signal outputs


output reg ALU_src_do,
output reg [1:0] Wr_data_sel_do,
output reg Reg_wr_do,
output reg Mem_rd_do,
output reg Mem_wr_do,
output reg [1:0] ALU_op_do

    );
   always @(posedge clk, negedge reset)
    begin
    if(reset==0)
    begin
    Read_data1_do<=0;
    Read_data2_do<=0;
    Sign_ext_do<=0;
    
    end
    else
    begin
    Read_data1_do<=Read_data1_fo;
    Read_data2_do<=Read_data2_fo;
    Sign_ext_do<=Sign_ext;
    Rs1_do<=Rs1_fo;
    Rs2_do<=Rs2_fo;
    PC_plus_4_do<=PC_plus_4_fo;
    Rd_do<=Rd_fo;
    I_aluctrl_fn7_do<=I_aluctrl_fn7_fo;
    I_aluctrl_fn3_do<=I_aluctrl_fn3_fo;
    
    
    ALU_src_do<=ALU_src;
    Wr_data_sel_do<=Wr_data_sel;
    Reg_wr_do<=Reg_wr;
    Mem_rd_do<=Mem_rd;
    Mem_wr_do<=Mem_wr;
    ALU_op_do<=ALU_op;
    
    end
    end
endmodule