`timescale 1ns / 1ps

module Datapath1(
input clk,
input reset
    );


wire PC_ctrl;
wire [31:0] Instruction_code;
wire [31:0] Read_data_1;
wire [31:0] Read_data_2;
wire [31:0] ALU_result;
wire [3:0] ALU_ctrl;
wire [11:0] Immediate;
wire [31:0] Sign_ext;
wire [31:0] Read_data_dm;
//wire [1:0] PC_src;
wire [1:0] PC_src;
wire ALU_src;
wire [1:0] Wr_data_sel;
wire Reg_wr;
wire Mem_rd;
wire Mem_wr;
wire [1:0] ALU_op;
wire [31:0] PC;
wire [31:0] PC_plus_4;
wire [31:0] Sign_ext_j;
wire [31:0] Add_result1;
wire [4:0] Rd_mo;
wire [1:0] ALU_op_do;
//////////////////////////////////////////////////////////////// MUX
wire [31:0] MUX1out;
wire [31:0] MUX2out;
wire [31:0] MUX3out;
wire [31:0] MUX4out;
wire [31:0] MUXAout;
wire [31:0] MUXBout;
wire [31:0] MUXPout;
wire [31:0] MUXQout;
//////////////////////////////////////////////////////////////// IF/ID to ID/EX connections
wire IF_ID_ctrl;
wire [31:0] PC_plus_4_fo;                              
wire [31:0] Instruction_code_fo;
wire [4:0] Rd_fo;
wire [5:0] I_aluctrl_fo;
wire [2:0] I_aluctrl_fn7_fo;
wire [2:0] I_aluctrl_fn3_fo;
wire Prediction_fo;
//wire [31:0] PC_fo;
wire [31:0] Add_result2_fo;
wire Flush;
//////////////////////////////////////////////////////////////// ID/EX to EX/MEM connections
wire [31:0] Read_data1_do;
wire [31:0] Sign_ext_do;

wire [31:0] PC_plus_4_do;
wire [31:0] Read_data2_do;
wire [4:0] Rd_do;
wire [2:0] I_aluctrl_fn7_do;
wire [2:0] I_aluctrl_fn3_do;
wire  [1:0] Wr_data_sel_do;
wire  Reg_wr_do;
wire  Mem_rd_do;
wire  Mem_wr_do;
wire ALU_src_do;
wire [4:0] Rs2_fo;
wire [4:0] Rs1_fo;
wire [4:0] Rs2_do;
wire [4:0] Rs1_do;

//////////////////////////////////////////////////////////////// EX/MEM to MEM/WB connections
wire [31:0] PC_plus_4_eo;
wire [31:0] ALU_result_eo;
wire [4:0] Rd_eo;
wire [1:0] Wr_data_sel_eo;
wire Reg_wr_eo;
wire [31:0] Read_data2_eo;
////////////////////////////////////////////////////////////////
wire [31:0] ALU_result_mo;
wire [31:0] PC_plus_4_mo;
wire Reg_wr_mo;
wire [1:0] Wr_data_sel_mo;
wire [31:0] Read_data_dm_mo;
//////////////////////////////////////////////////////////////// Fwding
wire [1:0] Fw_A;
wire [1:0] Fw_B;
wire [1:0] Fw_P;
wire [1:0] Fw_Q;

//////////////////////////////////////////////////////////////// MCU
wire [1:0] PC_src_s;
wire ALU_src_s;
wire [1:0] Wr_data_sel_s;
wire Reg_wr_s;
wire Mem_rd_s;
wire Mem_wr_s;
wire [1:0] ALU_op_s;

wire Mux_stall_sel;

///////////////////////////////////////////////////////////////// Branch predictor
wire Outcome;
wire Prediction;
wire [1:0] Nx_s;


//////////////////////////////////////////////////////////////// Branch target
wire [31:0] Sign_ext_b;
wire [31:0] Add_result2;


     Instruction_fetch a1 (PC_ctrl,MUX1out,clk,reset,      Instruction_code,PC,PC_plus_4);          //clk rem
     
     Register_file a2 (Rs1_fo,Rs2_fo,Rd_mo,MUX4out,Reg_wr_mo,reset,
                                Read_data_1,Read_data_2 );
                                
     Adder a2_1 (PC,Sign_ext_j,                     Add_result1);
     Adder a2_2 (PC,Sign_ext_b,                    Add_result2);
                                
     Main_control_unit a3(Prediction_fo,Outcome,Instruction_code_fo,clk,reset,               
                                       PC_src, ALU_src ,Wr_data_sel,Reg_wr,Mem_rd,Mem_wr,ALU_op,Flush);
                               
     ALU a4 (MUXAout,MUXBout,ALU_ctrl,       Zero,ALU_result);
     
     ALU_control a5 (ALU_op_do,I_aluctrl_fn7_do,I_aluctrl_fn3_do,      ALU_ctrl);
     
     Immediate_gen a6 (Instruction_code_fo,     Immediate);
     
     Sign_extension a7 (Immediate,    Sign_ext);
     Sign_extension_j a7_1 (Instruction_code,           Sign_ext_j );
     Sign_extension_b a7_2(Instruction_code,           Sign_ext_b);

     
     //Mux2_1 m (A,B,S,       Y);
     //Mux3_1 m1 (A1,B1,C1, S,      Y1);
     
     Data_memory a8 (ALU_result_eo,Read_data2_eo,Mem_wr_eo,Mem_rd_eo,reset,              Read_data_dm);
     ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     
     Mux4_1 m1 (MUX2out,Add_result1,PC_plus_4_fo,Add_result2_fo,PC_src_s,         MUX1out);
     Mux2_1 m2 (PC_plus_4,Add_result2,Prediction,      MUX2out);
     Mux2_1 m3 (Read_data2_do,Sign_ext_do,ALU_src_do,     MUX3out);
     
     Mux3_1 mA (Read_data1_do,ALU_result_eo,Read_data_dm_mo,Fw_A,       MUXAout);
     Mux3_1 mB (MUX3out,ALU_result_eo,Read_data_dm_mo,Fw_B,       MUXBout);
     Mux3_1 m4 (ALU_result_mo,PC_plus_4_mo,Read_data_dm_mo,Wr_data_sel_mo,      MUX4out);
     
     Mux2_1 mP (Read_data_1,ALU_result_eo,Fw_P,       MUXPout);
     Mux2_1 mQ (Read_data_2,ALU_result_eo,Fw_Q,      MUXQout);
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      
     IF_ID p1 (Prediction,Add_result2,IF_ID_ctrl,Instruction_code,PC_plus_4,clk,reset,Flush,                                                                     
                    PC_plus_4_fo,Rs1_fo,Rs2_fo,Instruction_code_fo,Rd_fo,I_aluctrl_fn7_fo,I_aluctrl_fn3_fo,Prediction_fo,Add_result2_fo);
                    
     ID_EX p2 (PC_plus_4_fo,Rs1_fo,Rs2_fo,Read_data_1,Read_data_2,Sign_ext,Rd_fo,I_aluctrl_fn7_fo,I_aluctrl_fn3_fo,ALU_src_s,Wr_data_sel_s,Reg_wr_s,Mem_rd_s,Mem_wr_s,ALU_op_s,clk,reset,
                      PC_plus_4_do,Read_data1_do,Read_data2_do,Sign_ext_do,Rd_do,I_aluctrl_fn7_do,I_aluctrl_fn3_do,Rs1_do,Rs2_do,ALU_src_do,Wr_data_sel_do,Reg_wr_do,Mem_rd_do,Mem_wr_do,ALU_op_do);
                      
     EX_MEM p3 (PC_plus_4_do,Read_data2_do,ALU_result,Rd_do,Wr_data_sel_do,Reg_wr_do,Mem_rd_do,Mem_wr_do,clk,reset,
                                 PC_plus_4_eo,Read_data2_eo,ALU_result_eo,Rd_eo,Wr_data_sel_eo,Reg_wr_eo,Mem_rd_eo,Mem_wr_eo); 
                                 
     MEM_WB p4 (PC_plus_4_eo,Read_data_dm,ALU_result_eo,Rd_eo,Wr_data_sel_eo,Reg_wr_eo,clk,reset,
                                            PC_plus_4_mo,Read_data_dm_mo,ALU_result_mo,Rd_mo,Wr_data_sel_mo,Reg_wr_mo); 
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      
      Forwarding r1 (Instruction_code_fo,Rd_mo,Rs1_do,Rs2_do,Rs1_fo,Rs2_fo,Rd_eo,Reg_wr_eo,Reg_wr_mo,       Fw_A,Fw_B,Fw_P,Fw_Q);
      Stalling r2 (Mem_rd_do,Rd_do,Rs1_fo,Rs2_fo,      PC_ctrl,IF_ID_ctrl,Mux_stall_sel);
      
      MUX_stall r3 (PC_src,ALU_src,Wr_data_sel,Reg_wr,Mem_rd,Mem_wr,ALU_op,Mux_stall_sel,        
                              PC_src_s,ALU_src_s,Wr_data_sel_s,Reg_wr_s,Mem_rd_s,Mem_wr_s,ALU_op_s);
                              
      Comparator r4(I_aluctrl_fn3_fo,MUXPout,MUXQout,clk,reset,       Outcome);
      Branch_Predictor r5 (Instruction_code,Outcome,clk,reset,           Prediction,Nx_s);
endmodule
