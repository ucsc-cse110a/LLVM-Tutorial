	.text
	.file	"callee_opt.ll"
	.globl	callee                          # -- Begin function callee
	.p2align	4, 0x90
	.type	callee,@function
callee:                                 # @callee
	.cfi_startproc
# %bb.0:                                # %entry
	movq	%rdi, -8(%rsp)
	movl	(%rdi), %eax
	incl	%eax
	retq
.Lfunc_end0:
	.size	callee, .Lfunc_end0-callee
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$0, 4(%rsp)
	movl	$4, (%rsp)
	movq	%rsp, %rdi
	callq	callee
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
