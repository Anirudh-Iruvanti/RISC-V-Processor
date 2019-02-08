`timescale 1ns / 1ps


module Data_memory(
input [31:0] Addr_dm,
input [31:0] Write_data_dm,
input Mem_wr,
input Mem_rd,
//input clk,
input reset,
output reg [31:0] Read_data_dm
 );
    
reg [7:0] Mem [31:0];

always @(negedge reset)
begin    
Mem[0]<=8'h00;Mem[1]<=8'h01;Mem[2]<=8'h02;Mem[3]<=8'h03;
Mem[4]<=8'h04;Mem[5]<=8'h05;Mem[6]<=8'h06;Mem[7]<=8'h07;
Mem[8]<=8'h08;Mem[9]<=8'h09;Mem[10]<=8'h0a;Mem[11]<=8'h0b;
Mem[12]<=8'h0c;Mem[13]<=8'h0d;Mem[14]<=8'h0e;Mem[15]<=8'h0f;
Mem[16]<=8'h10;Mem[17]<=8'h11;Mem[18]<=8'h12;Mem[19]<=8'h13;
Mem[20]<=8'h14;Mem[21]<=8'h15;Mem[22]<=8'h16;Mem[23]<=8'h17;
Mem[24]<=8'h18;Mem[25]<=8'h19;Mem[26]<=8'h1a;Mem[27]<=8'h1b;
Mem[28]<=8'h1c;Mem[29]<=8'h1d;Mem[30]<=8'h1e;Mem[31]<=8'h1f;
end
    

//always @(Addr_dm)
//begin  
//if(Mem_rd ==1)
//begin
//Read_data_dm={Mem[Addr_dm+3],Mem[Addr_dm+2],Mem[Addr_dm+1],Mem[Addr_dm]};
//end
//if(Mem_wr==1)
//begin
//{Mem[Addr_dm+3],Mem[Addr_dm+2],Mem[Addr_dm+1],Mem[Addr_dm]}=Write_data_dm;
//end
//end

always @(Addr_dm)
begin  
if(Mem_rd ==1)
begin
Read_data_dm<={Mem[Addr_dm+3],Mem[Addr_dm+2],Mem[Addr_dm+1],Mem[Addr_dm]};
end
end

always @(Addr_dm)
begin
if(Mem_wr==1)
begin
{Mem[Addr_dm+3],Mem[Addr_dm+2],Mem[Addr_dm+1],Mem[Addr_dm]}<=Write_data_dm;
end
end

endmodule

