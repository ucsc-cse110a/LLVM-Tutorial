	.text
	.file	"example.ll"
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	leaq	.Lprompt(%rip), %rdi
	xorl	%eax, %eax
	callq	printf@PLT
	leaq	.Lint_format(%rip), %rdi
	leaq	4(%rsp), %rsi
	xorl	%eax, %eax
	callq	scanf@PLT
	movl	4(%rsp), %esi
	addl	$5, %esi
	leaq	.Lresult_str(%rip), %rdi
	xorl	%eax, %eax
	callq	printf@PLT
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.Lprompt,@object                # @prompt
	.section	.rodata.str1.16,"aMS",@progbits,1
	.p2align	4
.Lprompt:
	.asciz	"Enter a number: "
	.size	.Lprompt, 17

	.type	.Lresult_str,@object            # @result_str
	.p2align	4
.Lresult_str:
	.asciz	"Your number plus 5 is: %d\n"
	.size	.Lresult_str, 27

	.type	.Lint_format,@object            # @int_format
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lint_format:
	.asciz	"%d"
	.size	.Lint_format, 3

	.section	".note.GNU-stack","",@progbits
