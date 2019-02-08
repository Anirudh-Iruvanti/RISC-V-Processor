module Sign_extension_b(
input [31:0] Instruction_code,
//input [19:0] Immediate12,                 // 12 bit input to be sign extended for branch  
output reg [31:0] Sign_ext_b      // 32 bit sign extended output for branch
);

reg [11:0] Immediate12_branch;
always @(Instruction_code)
begin
Immediate12_branch<={Instruction_code[31],Instruction_code[7],Instruction_code[30:25],Instruction_code[11:8]};
end

always @(Immediate12_branch)
begin
Sign_ext_b[31:0]<={{19{Immediate12_branch[11]}},Immediate12_branch,1'b0}; // 12 bits to be ext for 20 bits input branch along with shift left 1
end

endmodule