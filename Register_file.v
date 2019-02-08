`timescale 1ns / 1ps

module Register_file(
    input [4:0] Read_reg_num_1,
    input [4:0] Read_reg_num_2,
    input [4:0] Write_reg_num,
    input [31:0] Write_data,
    input Reg_write,
//    input clk,
    input reset,    
    output [31:0] Read_data_1,
    output [31:0] Read_data_2  
    );

reg [31:0] Regfile [31:0];

assign Read_data_1=Regfile[Read_reg_num_1];
assign Read_data_2=Regfile[Read_reg_num_2];

always @(negedge reset)
begin
if(reset==0)

Regfile[0]<=32'h00000000; Regfile[1]<=32'h00000001; Regfile[2]<=32'h00000002; Regfile[3]<=32'h00000003;
Regfile[4]<=32'h00000004; Regfile[5]<=32'h00000005; Regfile[6]<=32'h00000006; Regfile[7]<=32'h00000007;
Regfile[8]<=32'h00000008; Regfile[9]<=32'h00000009; Regfile[10]<=32'h0000000a; Regfile[11]<=32'h0000000b;
Regfile[12]<=32'h0000000c; Regfile[13]<=32'h0000000d; Regfile[14]<=32'h0000000e; Regfile[15]<=32'h0000000f;
Regfile[16]<=32'h00000010; Regfile[17]<=32'h00000011; Regfile[18]<=32'h00000012; Regfile[19]<=32'h00000013;
Regfile[20]<=32'h00000014; Regfile[21]<=32'h00000015; Regfile[22]<=32'h00000016; Regfile[23]<=32'h00000017;
Regfile[24]<=32'h00000018; Regfile[25]<=32'h00000019; Regfile[26]<=32'h0000001a; Regfile[27]<=32'h000001b;
Regfile[28]<=32'h0000001c; Regfile[29]<=32'h0000001d; Regfile[30]<=32'h0000001e; Regfile[31]<=32'h0000001f;

//Regfile[3]=32'hFFFFFFFD;  checking negative num multiplication

end

always @(Write_reg_num,Write_data)
begin
if(Reg_write ==1)
begin
Regfile[Write_reg_num]<=Write_data;// copying "write_data" data from last stage to Write data input
end
end

endmodule