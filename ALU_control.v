`timescale 1ns / 1ps

module ALU_control(
input [1:0] ALU_op,
input [2:0] Fn7,          //fn7 ;  I[31,30,25]
input [2:0] Fn3,          //fn3; I[14,13,12]
output reg [3:0] ALU_ctrl
//output Reg_wr
    );
wire [7:0] fn_fld;   
assign fn_fld={ALU_op,Fn7,Fn3};   
//assign Reg_wr= 1'b1;

always @(fn_fld)
begin
casex(fn_fld)
8'b10000000: ALU_ctrl<=4'b0010;//add and jal
8'b10010000: ALU_ctrl<=4'b0110;//sub
8'b10000111: ALU_ctrl<=4'b0000;//AND
8'b10000110: ALU_ctrl<=4'b0001;//OR
8'b10000100: ALU_ctrl<=4'b0111;//XOR
8'b10001000: ALU_ctrl<=4'b0011;//mul
8'b10000001: ALU_ctrl<=4'b0100;//sll
8'b10000101: ALU_ctrl<=4'b0101;//srl

8'b00xxxxxx:  ALU_ctrl<=4'b0010;//load-store

//8'b10xxxxxx:  ALU_ctrl=4'b0010;//jal
endcase
end

endmodule
