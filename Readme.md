5 Staged Pipelined RISC V Processor
---------------------------------------------

Codes available
-------------------

Main blocks:
Instruction fetch (includes Program counter), Instruction memory,
Register file, Main control unit, Datapath

Arithmetic blocks:
ALU, ALU control

Data transfer (Load/store) blocks:
Data memory, Immediate generator,

Conditional and unconditional jump blocks :
Comparator, Adder

Hazard detection blocks:
Stalling unit, Forwarding unit, Branch predictor

Pipelined register blocks:
IF_ID, ID_EX, EX_MEM, MEM_WB

( The  5 stages 
   IF     - Instruction fetch stage
   ID    - Instruction decode stage
   EX    - Execution stage
   MEM - Memory stage
   WB   - Writeback stage )
   
Connector/Helping blocks:
MUX, Sign extension, 
   
Testbench:
Test_datapath
-----------------------------------------------------

NOTE:
---------
A pdf document has been provided under the name "RISCV Proceesor Datapath Design", which
explains in detail the flowchart/block level design and the datapath.

------------------------------------------------------

Purpose:
-----------

This project demonstrates the working of a 32 bit, RISC V processor, which is a free and open ISA (Instruction Set Architecture) enabling open standard collaboration. The RISC-V ISA was originally developed in the Computer Science Division of the EECS Department at the University of California, Berkeley. This project has been implemented for 5 stages of pipelining and includes data and control hazards.

https://riscv.org/risc-v-foundation/
https://bar.eecs.berkeley.edu/projects/riscv.html

------------------------------------------------------

Book Referred:
-------------------

David A. Patterson and John L. Hennessy, Computer Organization and Design RISC-V Edition: The Hardware Software Interface (The Morgan Kaufmann Series in Computer Architecture and Design)

Instruction set reference: https://riscv.org/specifications/

---------------------------------------------------------

HDL used:
-------------
Verilog

---------------------------------------------------------

License:
-----------

The RISC-V authors aim to provide several CPU designs freely available under BSD licenses.
For further license information, read LICENSE.txt file.

------------------------------------------------------

