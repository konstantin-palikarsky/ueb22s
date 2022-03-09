	.text
	.globl	asmb
	.type	asmb, @function
asmb:
.LFB0:
	.cfi_startproc

	/* Set up indexes */
	leaq (%rdi), %r8                 # LOW_END = x (pointer to first element)
	leaq -16(%rdi,%rsi), %r9 	     # HIGH_END = x + n - 16 (chars that fit in 1 SIMD register)
	cmpq %r8, %r9 					 # HIGH_END - LOW_END
	jl .L1							 # IF HIGH_END < LOW_END THEN END_FUNCTION

	/* Set up mask */
	movq $0x08090A0B0C0D0E0F, %rax   # load first half of mask in rax 
	movq %rax, %xmm2				 # load rax to xmm2

	movq $0x0001020304050607, %rax   # load second half of mask in rax
	movq %rax, %xmm3	             # load rax to xmm3

	movlhps %xmm3, %xmm2 			 # combine mask in xmm2 using move low to high

.L3:
	/* Read, Shuffle and Write bytes */
	movdqu (%r8), %xmm0 		     # read bytes from LOW_END to xmm0		
	pshufb %xmm2, %xmm0				

	movdqu (%r9), %xmm1 		     # read bytes from HIGH_END to xmm1
	pshufb %xmm2, %xmm1				

	movdqu %xmm0, (%r9)         	 # write LOW_END bytes to HIGH_END
	movdqu %xmm1, (%r8)		 	     # write HIGH_END bytes to LOW_END

	/* Looping logic */
	addq $16, %r8					 # LOW_END  += 16;
	subq $16, %r9					 # HIGH_END -= 16;

	cmpq %r9, %r8 					 # LOW_END - HIGH_END
	jl .L3							 # IF HIGH_END >= LOW_END THEN LOOP

.L1:
	rep ret
	.cfi_endproc
.LFE0:
	.size	asmb, .-asmb
	.ident	"GCC: (Debian 6.3.0-18+deb9u1) 6.3.0 20170516"
	.section	.note.GNU-stack,"",@progbits
