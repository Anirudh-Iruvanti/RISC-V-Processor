`timescale 1ns / 1ps

module Instruction_memory(
    input [31:0] PC,
    input reset,
    output [31:0] Instruction_Code
   );
    
    
reg [7:0] Mem [63:0];


assign Instruction_Code= {Mem[PC+3],Mem[PC+2],Mem[PC+1],Mem[PC]}; //little endian

always @(negedge reset)

begin

if (reset==0)
begin


//R type testing
//Mem[0]=8'h33;Mem[1]=8'h82;Mem[2]=8'h21;Mem[3]=8'h00;    //add
//Mem[4]=8'hB3;Mem[5]=8'h82;Mem[6]=8'h21;Mem[7]=8'h40;   //sub
//Mem[8]=8'h33;Mem[9]=8'hF3;Mem[10]=8'h21;Mem[11]=8'h00; //AND
//Mem[12]=8'hB3;Mem[13]=8'hE3;Mem[14]=8'h21;Mem[15]=8'h00; //OR
//Mem[16]=8'h03;Mem[17]=8'h34;Mem[18]=8'h41;Mem[19]=8'h00; //lw
//Mem[20]=8'h23;Mem[21]=8'h30;Mem[22]=8'h3A;Mem[23]=8'h00; //sw
//Mem[24]=8'hEF;Mem[25]=8'h00;Mem[26]=8'h80;Mem[27]=8'h0C; //jal   
//Mem[24]=8'hB3;Mem[25]=8'h04;Mem[26]=8'h31;Mem[27]=8'h02;//mul
//Mem[28]=8'h33;Mem[29]=8'h15;Mem[30]=8'h31;Mem[31]=8'h00;//sll
//Mem[32]=8'hB3;Mem[33]=8'h55;Mem[34]=8'h31;Mem[35]=8'h00;//srl
//Mem[36]=8'h13;Mem[37]=8'h86;Mem[38]=8'h11;Mem[39]=8'h00;//mul

//R type test individual
//Mem[0]=8'h33;Mem[1]=8'h82;Mem[2]=8'h21;Mem[3]=8'h00;    //add
//Mem[0]=8'hB3;Mem[1]=8'h82;Mem[2]=8'h21;Mem[3]=8'h40;   //sub
//Mem[0]=8'h33;Mem[1]=8'hF3;Mem[2]=8'h21;Mem[3]=8'h00; //AND
//Mem[0]=8'hB3;Mem[1]=8'hE3;Mem[2]=8'h21;Mem[3]=8'h00; //OR
//Mem[0]=8'hB3;Mem[1]=8'h04;Mem[2]=8'h31;Mem[3]=8'h02;//mul
//Mem[0]=8'h33;Mem[1]=8'h15;Mem[2]=8'h31;Mem[3]=8'h00;//sll
//Mem[0]=8'hB3;Mem[1]=8'h55;Mem[2]=8'h31;Mem[3]=8'h00;//srl
//Mem[0]=8'h33;Mem[1]=8'hC6;Mem[2]=8'h21;Mem[3]=8'h00; //OR


//load test
//Mem[0]=8'h03;Mem[1]=8'h34;Mem[2]=8'h01;Mem[3]=8'h00; //lw

//store test
//Mem[0]=8'h23;Mem[1]=8'h30;Mem[2]=8'h3A;Mem[3]=8'h00; //sw

//jal test
//Mem[0]=8'hEF;Mem[1]=8'h00;Mem[2]=8'h80;Mem[3]=8'h0C; //jal  

//Forwarding cond1 testing
//Mem[0]=8'hB3;Mem[1]=8'h82;Mem[2]=8'h63;Mem[3]=8'h40;   //sub x5,x7,x6
//Mem[4]=8'h33;Mem[5]=8'h84;Mem[6]=8'h51;Mem[7]=8'h02;   //mul x8,x3,x5

//Stall test mux A
//Mem[0]=8'h03;Mem[1]=8'hA1;Mem[2]=8'h40;Mem[3]=8'h00;   //lw x2,4(x1)
//Mem[4]=8'h33;Mem[5]=8'h02;Mem[6]=8'h51;Mem[7]=8'h00;   //add x4,x2,x5

//Mem[0]=8'h03;Mem[1]=8'hA1;Mem[2]=8'h40;Mem[3]=8'h00;   //lw x2,4(x1)
//Mem[4]=8'h33;Mem[5]=8'h02;Mem[6]=8'h51;Mem[7]=8'h40;   //sub x4,x2,x5

//Stall test mux B
//Mem[0]=8'h03;Mem[1]=8'hA1;Mem[2]=8'h40;Mem[3]=8'h00;   //lw x2,4(x1)
//Mem[4]=8'h33;Mem[5]=8'h82;Mem[6]=8'h22;Mem[7]=8'h00;   //add x4,x5,x2

//branch taken test1
//Mem[0]=8'h63;Mem[1]=8'h04;Mem[2]=8'h21;Mem[3]=8'h00;     //beq x2,x2,L1
//Mem[4]=8'h33;Mem[5]=8'h82;Mem[6]=8'h62;Mem[7]=8'h00;     //add x4,x5,x6
//Mem[8]=8'hB3;Mem[9]=8'h03;Mem[10]=8'h94;Mem[11]=8'h00; //L1: add x7,x8,x9

//branch not taken test1
//Mem[0]=8'h63;Mem[1]=8'h04;Mem[2]=8'h31;Mem[3]=8'h00;    //beq x2,x3,L1
//Mem[4]=8'h33;Mem[5]=8'h82;Mem[6]=8'h62;Mem[7]=8'h00;   //add x4,x5,x6
//Mem[8]=8'hB3;Mem[9]=8'h03;Mem[10]=8'h94;Mem[11]=8'h00; //L1: add x7,x8,x9


//jal test

//Mem[0]=8'h33;Mem[1]=8'h82;Mem[2]=8'h22;Mem[3]=8'h00;    //add x4,x5,x2
//Mem[4]=8'hEF;Mem[5]=8'h00;Mem[6]=8'h00;Mem[7]=8'h01;   //jal x1,8
//Mem[8]=8'hB3;Mem[9]=8'h03;Mem[10]=8'h33;Mem[11]=8'h00; //add x7,x6,x3
//Mem[12]=8'h33;Mem[13]=8'h85;Mem[14]=8'hB4;Mem[15]=8'h00; //add x10,x9,x11



//Loop test
//Mem[0]=8'h33;Mem[1]=8'h82;Mem[2]=8'h22;Mem[3]=8'h00;    //add x4,x5,x2
//Mem[4]=8'hEF;Mem[5]=8'h00;Mem[6]=8'h00;Mem[7]=8'h01;   //jal x1,8
//Mem[8]=8'hB3;Mem[9]=8'h03;Mem[10]=8'h33;Mem[11]=8'h00; //add x7,x6,x3
//Mem[12]=8'h33;Mem[13]=8'h85;Mem[14]=8'hB4;Mem[15]=8'h00; //add x10,x9,x11

//test1

//Mem[0]=8'h13;Mem[1]=8'h0E;Mem[2]=8'h40;Mem[3]=8'h00;                    //addi x28,x0,4
//Mem[4]=8'h93;Mem[5]=8'h0E;Mem[6]=8'h40;Mem[7]=8'h00;                    //addi x29,x0,4
//Mem[8]=8'h93;Mem[9]=8'h02;Mem[10]=8'h10;Mem[11]=8'h00;                //addi x5,x0,1
//Mem[12]=8'h13;Mem[13]=8'h03;Mem[14]=8'h20;Mem[15]=8'h00;            //addi x6,x0,2
//Mem[16]=8'h13;Mem[17]=8'h05;Mem[18]=8'h10;Mem[19]=8'h00;            //addi x10,x0,1
//Mem[20]=8'h33;Mem[21]=8'h0E;Mem[22]=8'h5E;Mem[23]=8'h40;           //fact:sub x28,x28,x5
//Mem[24]=8'hB3;Mem[25]=8'h8E;Mem[26]=8'hCE;Mem[27]=8'h03;          //mul x29,x29,x28
//Mem[28]=8'hE3;Mem[29]=8'h5C;Mem[30]=8'h6E;Mem[31]=8'hFE;          //bge x28,x6,fact
//Mem[32]=8'h13;Mem[33]=8'h85;Mem[34]=8'h0E;Mem[35]=8'h00;           //addi x10,x29,0



//test


Mem[0]=8'h13;Mem[1]=8'h0E;Mem[2]=8'h40;Mem[3]=8'h00;                    //addi x28,x0,4
Mem[4]=8'h93;Mem[5]=8'h0E;Mem[6]=8'h40;Mem[7]=8'h00;                    //addi x29,x0,4
Mem[8]=8'h93;Mem[9]=8'h02;Mem[10]=8'h10;Mem[11]=8'h00;                //addi x5,x0,1
Mem[12]=8'h13;Mem[13]=8'h03;Mem[14]=8'h20;Mem[15]=8'h00;            //addi x6,x0,2
Mem[16]=8'h13;Mem[17]=8'h05;Mem[18]=8'h10;Mem[19]=8'h00;            //addi x10,x0,1
Mem[20]=8'h63;Mem[21]=8'h0A;Mem[22]=8'h0E;Mem[23]=8'h00;           //beq x28,x0,exit
Mem[24]=8'h33;Mem[25]=8'h0E;Mem[26]=8'h5E;Mem[27]=8'h40;           //fact:sub x28,x28,x5
Mem[28]=8'hB3;Mem[29]=8'h8E;Mem[30]=8'hCE;Mem[31]=8'h03;          //mul x29,x29,x28
Mem[32]=8'hE3;Mem[33]=8'h5C;Mem[34]=8'h6E;Mem[35]=8'hFE;          //bge x28,x6,fact
//Mem[36]=8'h13;Mem[37]=8'h85;Mem[38]=8'h0E;Mem[39]=8'h00;           //addi x10,x29,0
Mem[36]=8'h23;Mem[37]=8'h20;Mem[38]=8'hD5;Mem[39]=8'h01; 
////exit:





//test2
//Mem[0]=8'h13;Mem[1]=8'h0E;Mem[2]=8'h40;Mem[3]=8'h00;                    //addi x28,x0,4
//Mem[4]=8'h93;Mem[5]=8'h0E;Mem[6]=8'h40;Mem[7]=8'h00;                    //addi x29,x0,4
//Mem[8]=8'h93;Mem[9]=8'h02;Mem[10]=8'h10;Mem[11]=8'h00;                //addi x5,x0,1
//Mem[12]=8'h13;Mem[13]=8'h03;Mem[14]=8'h20;Mem[15]=8'h00;            //addi x6,x0,2
//Mem[16]=8'h13;Mem[17]=8'h05;Mem[18]=8'h10;Mem[19]=8'h00;            //addi x10,x0,1
//Mem[20]=8'h63;Mem[21]=8'h0A;Mem[22]=8'h0E;Mem[23]=8'h00;           //beq x28,x0,exit
//Mem[20]=8'h33;Mem[21]=8'h0E;Mem[22]=8'h5E;Mem[23]=8'h40;           //fact:sub x28,x28,x5
//Mem[24]=8'hB3;Mem[25]=8'h8E;Mem[26]=8'hCE;Mem[27]=8'h03;          //mul x29,x29,x28
//Mem[28]=8'63;Mem[29]=8'h54;Mem[30]=8'h6F;Mem[31]=8'h02;          //bge x28,x6,fact
//Mem[32]=8'h13;Mem[33]=8'h85;Mem[34]=8'h0E;Mem[35]=8'h00;           //addi x10,x29,0
end
end
    
    
endmodule