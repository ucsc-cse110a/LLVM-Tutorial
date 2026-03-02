
llvm-as callee_opt.ll -o callee_opt.bc
llc callee_opt.bc -o callee_opt.x86
as callee_opt.x86 -o callee_opt.o
#
# # RV32I (base integer ISA):
# llc callee_opt.bc \
#    -mtriple=riscv32-unknown-elf \
#    -march=rv32i \
# 	-mattr=+m,+a \
# 	-filetype=asm \
# 	-o callee_opt_rv32i.s
# 
# # Minimal strict RV32I: 
# llc callee_opt.bc \
#    -mtriple=riscv32-unknown-elf \
#    -march=rv32i \
# 	-filetype=asm \
# 	-o callee_opt_rv32i.s
# 
# # RV32F: 
# llc callee_opt.bc \
#    -mtriple=riscv32-unknown-elf \
#    -march=rv32if \
# 	-filetype=asm \
# 	-o callee_opt_rv32if.s
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
# 
# # Then use it like this:
# For example, llc -mcpu=mycpu -mattr=+feature1,-feature2
# 
