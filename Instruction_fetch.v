`timescale 1ns / 1ps

module Instruction_fetch(
    input PC_ctrl,
    input [31:0] PC_in,
    input clk,
    input reset,
    output [31:0] Instruction_Code,
    output reg [31:0] PC,
    output reg [31:0] PC_plus_4
    
    );

//reg [31:0] PC;

reg clk_stall;

always @(clk)
begin
if(PC_ctrl==0)
clk_stall<=0;
else
clk_stall<=clk;
end


Instruction_memory im1(PC, reset, Instruction_Code);
    
always @(posedge clk_stall, negedge reset)
begin 
if(reset==0)
            begin
            PC<=0;
            PC_plus_4<=4;
            end
else
            begin
            PC<=PC_in;
            PC_plus_4<=PC_in+4;
            end
end

endmodule