#
file=callee_opt
arch=x86-64
arch_triple=x86_64-pc-linux-gnu
#
# arch=riscv32
# attr="-mattr=+f,+m"
# arch_triple=riscv32-unknown-elf
#
llvm-as $file.ll -o $file.bc
# Generate assembly code for target arch:
# llc -mtriple=${type}-unknown-elf -mattr=help
# For example, llc -mcpu=mycpu -mattr=+feature1,-feature2
llc $file.bc -march=$arch \
   $attr \
   -filetype=asm \
   -o $file.s
#
llvm-mc \
  -triple=$arch_triple \
  -filetype=obj $file.s -o $file.o
# or more commonly:
# clang -c file.s -target riscv32-unknown-elf -o $file.o
# clang main.o callee_opt.o -o myprogram
clang $file.o -o $file
#
# clang automatically adds:
# crt0 startup code
# libc
# Linker script for ELF executable
#
# llvm-as callee_opt.ll -o callee_opt.bc
# llc callee_opt.bc -o callee_opt.x86
# as callee_opt.x86 -o callee_opt.o
#
# # RV32I (base integer ISA):
# llc callee_opt.bc \
#    -mtriple=riscv32-unknown-elf \
#    -march=rv32i \
#  	 -mattr=+m,+a \
# 	 -filetype=asm \
# 	 -o callee_opt_rv32i.s
# 
# # Minimal strict RV32I: 
# llc callee_opt.bc \
#    -mtriple=riscv32-unknown-elf \
#    -march=rv32i \
# 	 -filetype=asm \
# 	 -o callee_opt_rv32i.s
# 
# # RV32F: 
# llc callee_opt.bc \
#    -mtriple=riscv32-unknown-elf \
#    -march=rv32if \
# 	 -filetype=asm \
# 	 -o callee_opt_rv32if.s
# 
# # DOUBLE PRECISION
# -march=rv32id 
# 
# Tells LLVM which architecture + vendor + OS ABI to target.
# -mtriple=
#    riscv32-unknown-elf (bare metal)
#    riscv32-linux-gnu (Linux userspace)
# 
# -march=
# Defines the ISA variant.
# Common RISC-V ISA strings:
# ISA	Meaning
# rv32i	32-bit base integer
# rv32im	+ integer multiply/divide
# rv32if	+ single-precision float
# rv32imf	  I + M + F
# rv32imfd  I + M + F + D
# rv64gc	64-bit, general-purpose (most common Linux RV64)
# 
# llc --version
#   shows possible arch
# 
# To generate:
# 	x86 (default) → no flags needed
# 	RV32I → -mtriple=riscv32-unknown-elf -march=rv32i
# 	RV32F → -march=rv32if
# 
# llc -march=riscv32 -mattr=help
# lists features like this:
#   +f      Enable single-precision floating point
#   +d      Enable double-precision floating point
#   +m      Enable integer multiply/divide
#   +a      Enable atomic instructions
#   +c      Enable compressed instructions
#   +v      Enable vector extension
#   ...
# 
# # Then use it like this:
# For example, llc -mcpu=mycpu -mattr=+feature1,-feature2
# 
# llc input.bc \
#	-march=riscv32 \
#   -mattr=+m \
#   -filetype=asm \
#   -o out.s
#

## Assemble LLVM IR
# llvm-as callee_opt.ll -o callee_opt.bc
## Generate RISC-V assembly
# llc callee_opt.bc -march=rv32imf -filetype=asm -o callee_opt.s
## Assemble to object
# clang -c callee_opt.s -target riscv32-unknown-elf -o callee_opt.o
## Compile main.c for RISC-V
# riscv32-unknown-elf-gcc -c main.c -o main.o
## Link into executable
# riscv32-unknown-elf-gcc main.o callee_opt.o -o myprogram.elf
#
# riscv32-unknown-elf-gcc / riscv32-unknown-elf-ld
# This will produce a valid RISC-V ELF executable
# Cannot run on x86_64 — you’ll need a RISC-V emulator or board.
# Need to download a riscv32-... for Xss-compiling.
#
# llc -march=x86-64 -mcpu=help
#   Getting information about the x86-64 CPU and available features.
