`timescale 1ns / 1ps

module Mux2_1 #(parameter n=32)(
    input [n-1:0] A,
    input [n-1:0] B,
    input S,
    output reg [n-1:0] Y
    );
    
    always@(A,B,S)
    begin
    case(S)
    0: Y=A;
    1: Y=B;
//    default:Y=A;
    endcase
    end
    
endmodule