`timescale 1ns / 1ps

module Immediate_gen(
input [31:0] Instruction_code,
output reg [11:0] Immediate
);

wire [6:0] op;

assign op=Instruction_code[6:0];

always @(Instruction_code)
begin

if (op==7'b0000011||7'b0010011) // lw or addi
begin
Immediate<=Instruction_code[31:20];
end


if (op==7'b0100011) //sw
begin
Immediate<={Instruction_code[31:25],Instruction_code[11:7]};
end

end


endmodule
