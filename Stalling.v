`timescale 1ns / 1ps

module Stalling(
input Mem_rd_do,         //Mem read control from ID/EX
input [4:0] Rd_do,         //5 bit dest  field from ID/EX
input [4:0] Rs1_fo,        //5 bit source reg 1 field from IF/ID
input [4:0] Rs2_fo,        //5 bit source reg 2 field from IF/ID

output reg PC_ctrl,
output reg IF_ID_ctrl,
output reg Mux_stall_sel
    );
    
always @(Mem_rd_do,Rd_do,Rs1_fo)      
begin
if((Mem_rd_do==1) && (Rd_do==Rs1_fo))
begin
PC_ctrl<=0;
IF_ID_ctrl<=0;
Mux_stall_sel<=0;
end
else
begin
PC_ctrl<=1;
IF_ID_ctrl<=1;
Mux_stall_sel<=1;
end
end



always @(Mem_rd_do,Rd_do,Rs2_fo)
begin
if((Mem_rd_do==1) && (Rd_do==Rs2_fo))
begin
PC_ctrl<=0;
IF_ID_ctrl<=0;
Mux_stall_sel<=0;
end
else
begin
PC_ctrl<=1;
IF_ID_ctrl<=1;
Mux_stall_sel<=1;
end
end


//always @(Mem_rd_do,Rd_do,Rs1_fo,Rs2_fo)
//begin
//if((Mem_rd_do==1) && ((Rd_do==Rs1_fo) || (Rd_do==Rs2_fo)))
//begin
//PC_ctrl<=1;
//IF_ID_ctrl<=1;
//Mux_stall_sel<=1;
//end
//else
//begin
//PC_ctrl<=0;
//IF_ID_ctrl<=0;
//Mux_stall_sel<=0;
//end
//end


endmodule
