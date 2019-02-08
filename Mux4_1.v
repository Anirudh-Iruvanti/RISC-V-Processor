`timescale 1ns / 1ps

module Mux4_1 #(parameter n=32)(
    input [n-1:0] A,
    input [n-1:0] B,
    input [n-1:0] C,
    input [n-1:0] D,
    
    input [1:0] S,
    output reg [n-1:0] Y
    );
    
    always@(A,B,C,D,S)
    begin
    case(S)
    2'b00: Y=A;
    2'b01: Y=B;
    2'b10: Y=C;
    2'b11: Y=D;
    endcase
    end
    
endmodule