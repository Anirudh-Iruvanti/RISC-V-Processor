`timescale 1ns / 1ps


module Adder(
input [31:0] P,
input [31:0] Q,
output reg [31:0] Add_result
    );
    
    always@(P,Q)
    begin
    Add_result<=P+Q;
    end    
endmodule