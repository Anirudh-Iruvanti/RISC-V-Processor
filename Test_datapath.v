`timescale 1ns / 1ps

module Test_Datapath(
    );
  reg clk;
  reg reset;
  
  Datapath1 d1(clk,reset);
  
initial begin  
clk=0;
repeat(40)
#5 clk=~clk;
#5 $finish;
end

initial begin
reset=0;
#2 reset=1;
end
    
endmodule