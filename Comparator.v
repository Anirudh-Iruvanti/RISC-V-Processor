`timescale 1ns / 1ps

module Comparator(
input [2:0] Fn3,
input [31:0] Read_data_1,
input [31:0] Read_data_2,
input clk,
input reset,
output reg Outcome
    );
    
    
always @(Read_data_1,Read_data_2,posedge clk,negedge reset)
begin
if(Fn3==3'b000 && reset==1)                                   //beq
        begin
        if(Read_data_1==Read_data_2)
        Outcome<=1;
        else
        Outcome<=0;
        end
else if(Fn3==3'b101&& reset==1)                            //bge
        begin
        if(Read_data_1>Read_data_2)
        Outcome<=1;
        else
        Outcome<=0; 
        end    
else if(Fn3==3'b100&& reset==1)                            //blt 
        begin       
        if(Read_data_1<Read_data_2)
        Outcome<=1;
        else
        Outcome<=0;   
        end 
else if(reset==0)
        begin
        Outcome<=1'bx;
        end         
end
    

endmodule