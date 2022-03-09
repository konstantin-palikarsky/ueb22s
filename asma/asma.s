	.text
	.globl	asma
	.type	asma, @function
asma:
.LFB0:
	.cfi_startproc

	/** Setup Mask */
	movq $0x08090A0B0C0D0E0F, %rax   # load first half of mask in rax which is caller saved
	movq %rax, %xmm2				 # load rax to xmm2

	movq $0x0001020304050607, %rax   # load second half of mask in rax
	movq %rax, %xmm3	             # load rax to xmm3

	movlhps %xmm3, %xmm2 			 # combine mask in xmm2 using move low to high

	/** Poll, Shuffle and Write String */

	movdqu (%rdi), %xmm0			 # load 128 bits from memory unaligned into xmm0
	pshufb %xmm2, %xmm0				 # pshufb is executed on mask 0x000102030405060708090A0B0C0D0E0F
	movdqu %xmm0, (%rdi)	         # write xmm0 to memory

	rep ret
	.cfi_endproc
.LFE0:
	.size	asma, .-asma
	.ident	"GCC: (Debian 6.3.0-18+deb9u1) 6.3.0 20170516"
	.section	.note.GNU-stack,"",@progbits
