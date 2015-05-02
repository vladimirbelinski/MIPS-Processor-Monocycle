# MIPS-Processor-Monocycle

This is an implementation of a system in VHDL simulating a CPU with MIPS architecture.
The system consists of 32 registers of 32 bits each, organized into a structure which is conventionally called Bank Registers.

The program and data memory have a storage capacity of 256 bytes; the processing word in the system is a 32 bit vector; all the instructions that the processor works with are 32 bits long; the entity produced process 32-bit numbers written in two's complement notation.

The technique utilized is the monocycle implementation (all instruction cycle stages must take place in a single clock cycle).

Set of instructions supported:

LW, SW, AND, ADD, ADDI, SUB, SLT, SLTI, BEQ, BNE, J, JAL and JR.
