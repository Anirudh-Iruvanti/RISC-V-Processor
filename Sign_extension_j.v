module Sign_extension_j(
input [31:0] Instruction_code,
//input [19:0] Immediate20,                 // 20 bit input to be sign extended for jal  
output reg [31:0] Sign_ext_j      // 32 bit sign extended output for jal
);

reg [19:0] Immediate20;

always @(Instruction_code)
begin
Immediate20={Instruction_code[31],Instruction_code[19:12],Instruction_code[20],Instruction_code[30:21]};
end

always @(Immediate20)
begin
Sign_ext_j[31:0]<={{12{Immediate20[19]}},Immediate20}; // 12 bits to be extendend for 20 bits input, jal
end

endmodule