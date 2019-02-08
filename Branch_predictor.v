`timescale 1ns / 1ps

module Branch_Predictor(
input [31:0] Instruction_code,
input Outcome,
input clk,
input reset,
output reg Prediction,
output reg [1:0] Nx_s
//output reg Flush

    );

reg [6:0] opcode;    
reg Prediction_b;

reg [1:0] Pr_s;
parameter SNT=2'b00,WNT=2'b01,WT=2'b10,ST=2'b11;

always @(Instruction_code)
begin
//if(reset==0)
//opcode<=7'b0000000;
//else
opcode<=Instruction_code[6:0];
end

always @(Nx_s,opcode,negedge reset)
begin
if(reset==0)
Pr_s<=WT;
else if(opcode==7'b1100011)
Pr_s<=Nx_s;  //#5
end



always @(Pr_s)
begin
//if(reset==0)
//Prediction_b<=0;
if(Pr_s==WT || Pr_s==ST)
Prediction_b<=1;
else if(Pr_s==WNT || Pr_s==SNT)
Prediction_b<=0;
end

always @(Prediction_b,opcode)
begin
if (opcode==7'b1100011)
Prediction<=Prediction_b;
else
Prediction<=0;
end


//always @(Prediction)
//begin
//if(Prediction==1)
//begin
////Flush<=1'b0;

//end
//else if(Prediction==0)
//begin
////Flush<=1'b1;

//end
//end



always @(Pr_s,Outcome,posedge clk,negedge reset)
begin
if(opcode==7'b1100011)
begin
if(Pr_s==SNT)// && Outcome==1'b0 )
        begin
        if(Outcome==1'b0)
        Nx_s <=SNT; 
//else if(Pr_s==SNT && Outcome==1'b1 )
        else if(Outcome==1'b1 )
        Nx_s <=WNT; 
        end
        
else if(Pr_s==WNT)// && Outcome==1'b0 )
        begin
        if(Outcome==1'b0 )
        Nx_s <=SNT; 
//else if(Pr_s==WNT && Outcome==1'b1 ) 
        else if (Outcome==1'b1 )
        Nx_s <=WT; 
        end
    
else if(Pr_s==WT)// && Outcome==1'b0 )    
        begin
        if (Outcome==1'b0 ) 
        Nx_s <=WNT; 
//else if(Pr_s==WT && Outcome==1'b1 )  
        else if(Outcome==1'b1 ) 
        Nx_s <=ST; 
        end

else if(Pr_s==ST)// && Outcome==1'b0 )   
        begin
        if (Outcome==1'b0 ) 
        Nx_s <=WT;
//else if(Pr_s==ST && Outcome==1'b1 ) 
        else if(Outcome==1'b1 ) 
        Nx_s <=ST;
        end
end 
end

endmodule