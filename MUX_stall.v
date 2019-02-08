`timescale 1ns / 1ps

module MUX_stall(
input [1:0] PC_src,
input ALU_src,
input [1:0] Wr_data_sel,
input Reg_wr,
input Mem_rd,
input Mem_wr,
input [1:0] ALU_op,

input Mux_stall_sel,


output reg [1:0] PC_src_s,
output reg ALU_src_s,
output reg [1:0] Wr_data_sel_s,
output reg Reg_wr_s,
output reg Mem_rd_s,
output reg Mem_wr_s,
output reg [1:0] ALU_op_s
    );
    
always @(PC_src,ALU_src,Wr_data_sel,Reg_wr,Mem_rd,Mem_wr,ALU_op,Mux_stall_sel)
begin            
case(Mux_stall_sel)        
1'b1: begin    
         PC_src_s <= PC_src;
         ALU_src_s <= ALU_src;
         Wr_data_sel_s <= Wr_data_sel;
         Reg_wr_s <= Reg_wr;
         Mem_rd_s <= Mem_rd;
         Mem_wr_s <= Mem_wr;
         ALU_op_s <= ALU_op;
         end
            
1'b0:  begin   
          PC_src_s <= 0;
          ALU_src_s <= 0;
          Wr_data_sel_s <= 0;
          Reg_wr_s <= 0;
          Mem_rd_s <= 0;
          Mem_wr_s <= 0;
          ALU_op_s <= 0;
          end
endcase           
end  
    
    
    
    
    
    
    
    
    
endmodule
