module Sign_extension(
input [11:0] Immediate,                         // 12 bit input to be sign extended for load-store
//input [19:0] Immediate20,                 // 20 bit input to be sign extended for jal  
output reg [31:0] Sign_ext                  // 32 bit sign extended output for load-store
//output reg [31:0] Sign_ext_jump      // 32 bit sign extended output for jal
);

always @(Immediate)
begin

Sign_ext[31:0]<={{20{Immediate[11]}},Immediate[11:0]}; // 20 bits to be extendend for 12 bits input, load-store

end

//always @(Immediate20)
//begin

//Sign_ext_jump[31:0]<={{12{Immediate20[19]}},Immediate20[19:0]}; // 12 bits to be extendend for 20 bits input, jal

//end

endmodule