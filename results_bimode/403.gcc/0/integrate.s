	.file	"integrate.i"
	.section	.rodata.str1.32,"aMS",@progbits,1
	.align 32
.LC0:
	.string	"varargs function cannot be inline"
	.align 32
.LC1:
	.string	"function too large to be inline"
	.align 32
.LC4:
	.string	"address of an aggregate parameter is used; cannot be inline"
	.align 32
.LC3:
	.string	"no prototype, and parameter address used; cannot be inline"
	.align 32
.LC2:
	.string	"function with large aggregate parameter cannot be inline"
	.text
	.align 2
	.p2align 4,,15
.globl function_cannot_inline_p
	.type	function_cannot_inline_p,@function
function_cannot_inline_p:
.LFB1:
	pushq	%r12
.LCFI0:
	xorl	%eax, %eax
	pushq	%rbp
.LCFI1:
	pushq	%rbx
.LCFI2:
	movq	16(%rdi), %rdx
	movq	%rdi, %rbx
	movq	32(%rdx), %rdi
	call	tree_last
	movq	96(%rbx), %rdi
	movq	%rax, %rbp
	xorl	%eax, %eax
	call	list_length
	movzbl	26(%rbx), %ecx
	shrb	$6, %cl
	andl	$1, %ecx
	sall	$4, %ecx
	addl	%ecx, %eax
	testq	%rbp, %rbp
	leal	64(,%rax,8), %r12d
	je	.L2
	movq	void_type_node(%rip), %rcx
	cmpq	%rcx, 40(%rbp)
	je	.L2
	movl	$.LC0, %ecx
.L1:
	popq	%rbx
	popq	%rbp
	popq	%r12
	movq	%rcx, %rax
	ret
	.p2align 6,,7
.L2:
	xorl	%eax, %eax
	call	get_max_uid
	movl	$.LC1, %ecx
	leal	(%r12,%r12), %esi
	cmpl	%esi, %eax
	jg	.L1
	movq	96(%rbx), %rdx
	testq	%rdx, %rdx
	je	.L22
	.p2align 4,,7
.L11:
	movq	16(%rdx), %rax
	cmpb	$26, 56(%rax)
	je	.L25
	testq	%rbp, %rbp
	je	.L28
.L9:
	movzbl	24(%rax), %ebx
	subb	$19, %bl
	cmpb	$1, %bl
	ja	.L6
	movq	120(%rdx), %rdi
	cmpw	$37, (%rdi)
	je	.L27
.L6:
	movq	8(%rdx), %rdx
	testq	%rdx, %rdx
	jne	.L11
.L22:
	xorl	%eax, %eax
	call	get_max_uid
	cmpl	%r12d, %eax
	jg	.L29
.L12:
	xorl	%ecx, %ecx
	jmp	.L1
.L29:
	xorl	%eax, %eax
	xorl	%ebx, %ebx
	call	get_first_nonparm_insn
	testq	%rax, %rax
	movq	%rax, %rcx
	je	.L14
	cmpl	%r12d, %ebx
	jge	.L24
	.p2align 4,,7
.L19:
	movzwl	(%rcx), %eax
	leal	1(%rbx), %ebp
	movq	24(%rcx), %rcx
	subl	$13, %eax
	cmpw	$2, %ax
	cmovbe	%ebp, %ebx
	testq	%rcx, %rcx
	je	.L14
	cmpl	%r12d, %ebx
	jl	.L19
.L24:
	movl	$.LC1, %ecx
	jmp	.L1
.L14:
	cmpl	%r12d, %ebx
	jl	.L12
	jmp	.L24
.L27:
	movl	$.LC4, %ecx
	jmp	.L1
	.p2align 6,,7
.L28:
	testb	$2, 26(%rdx)
	je	.L9
	movl	$.LC3, %ecx
	jmp	.L1
.L25:
	movl	$.LC2, %ecx
	jmp	.L1
.LFE1:
.Lfe1:
	.size	function_cannot_inline_p,.Lfe1-function_cannot_inline_p
	.align 2
	.p2align 4,,15
.globl save_for_inline
	.type	save_for_inline,@function
save_for_inline:
.LFB2:
	pushq	%rbp
.LCFI3:
	movq	%rsp, %rbp
.LCFI4:
	pushq	%r15
.LCFI5:
	pushq	%r14
.LCFI6:
	pushq	%r13
.LCFI7:
	pushq	%r12
.LCFI8:
	pushq	%rbx
.LCFI9:
	subq	$200, %rsp
.LCFI10:
	cmpq	$0, return_label(%rip)
	movq	%rdi, -48(%rbp)
	je	.L191
.L31:
	xorl	%eax, %eax
	call	max_label_num
	movl	%eax, -76(%rbp)
	xorl	%eax, %eax
	call	get_first_label_num
	movl	%eax, %r14d
	xorl	%eax, %eax
	call	max_parm_reg_num
	movl	%eax, max_parm_reg(%rip)
	xorl	%eax, %eax
	call	max_reg_num
	movslq	max_parm_reg(%rip),%rcx
	movl	%eax, -84(%rbp)
	xorl	%eax, %eax
	cld
	salq	$3, %rcx
	leaq	15(%rcx), %rdx
	shrq	$3, %rcx
	andq	$-16, %rdx
	subq	%rdx, %rsp
	leaq	8(%rsp), %rdi
	movq	%rdi, parmdecl_map(%rip)
	rep
	stosq
	movq	-48(%rbp), %rcx
	movq	96(%rcx), %rdx
	testq	%rdx, %rdx
	je	.L175
	.p2align 4,,7
.L41:
	movq	120(%rdx), %rax
	cmpw	$34, (%rax)
	je	.L192
	orb	$8, 25(%rdx)
.L40:
	orb	$32, 25(%rdx)
	movq	8(%rdx), %rdx
	testq	%rdx, %rdx
	jne	.L41
.L175:
	movl	current_function_args_size(%rip), %eax
	movl	-76(%rbp), %ecx
	xorl	%edi, %edi
	movl	max_parm_reg(%rip), %r8d
	movl	-84(%rbp), %r9d
	xorl	%esi, %esi
	movl	%r14d, %edx
	movl	%eax, (%rsp)
	xorl	%eax, %eax
	call	gen_inline_header_rtx
	movq	%rax, -72(%rbp)
	movl	8(%rax), %ebx
	xorl	%eax, %eax
	movl	%ebx, -88(%rbp)
	call	preserve_data
	xorl	%eax, %eax
	call	get_insns
	cmpw	$18, (%rax)
	movq	%rax, -64(%rbp)
	jne	.L171
	movl	$18, %edi
	xorl	%eax, %eax
	call	rtx_alloc
	movq	-64(%rbp), %r9
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %r8
	movq	32(%r9), %r10
	movq	%r10, 32(%r8)
	movl	40(%r9), %eax
	movl	%eax, 40(%r8)
	movl	8(%r9), %eax
	movq	$0, 24(%r8)
	movq	$0, 16(%r8)
	movl	%eax, 8(%r8)
	movl	-84(%rbp), %r12d
	movl	-84(%rbp), %eax
	movq	%r8, -208(%rbp)
	incl	%eax
	decl	%r12d
	cltq
	leaq	15(,%rax,8), %rdi
	movl	rtx_length+136(%rip), %eax
	andq	$-16, %rdi
	subq	%rdi, %rsp
	decl	%eax
	leaq	8(%rsp), %rsi
	cmpl	$55, %r12d
	leal	16(,%rax,8), %eax
	movq	%rsi, reg_map(%rip)
	movl	%eax, -80(%rbp)
	jle	.L177
	movq	maybepermanent_obstack+24(%rip), %rdi
	movq	maybepermanent_obstack+32(%rip), %rcx
	movslq	%eax,%r13
	.p2align 4,,7
.L51:
	movslq	%r12d,%r15
	leaq	(%r13,%rdi), %r11
	leaq	0(,%r15,8), %rbx
	movq	%rbx, %r15
	addq	reg_map(%rip), %r15
	cmpq	%rcx, %r11
	ja	.L193
.L48:
	movq	%rbx, %rdx
	xorl	%eax, %eax
	addq	regno_reg_rtx(%rip), %rdx
	movq	(%rdx), %rsi
	movq	%r13, %rdx
	call	memcpy
	movq	maybepermanent_obstack+32(%rip), %rdx
	movq	maybepermanent_obstack+8(%rip), %rbx
	movq	maybepermanent_obstack+24(%rip), %r9
	movl	maybepermanent_obstack+44(%rip), %eax
	movq	maybepermanent_obstack+16(%rip), %rsi
	movq	%rdx, %rdi
	movslq	%eax,%rcx
	addq	%r13, %r9
	subq	%rbx, %rdi
	notl	%eax
	addq	%rcx, %r9
	movq	%rdx, %rcx
	cltq
	andq	%rax, %r9
	movq	%r9, maybepermanent_obstack+24(%rip)
	subq	%rbx, %r9
	cmpq	%rdi, %r9
	jle	.L50
	movq	%rdx, maybepermanent_obstack+24(%rip)
.L50:
	movq	maybepermanent_obstack+24(%rip), %rdi
	decl	%r12d
	movq	%rsi, (%r15)
	cmpl	$55, %r12d
	movq	%rdi, maybepermanent_obstack+16(%rip)
	jg	.L51
.L177:
	movl	-84(%rbp), %eax
	movq	regno_reg_rtx(%rip), %rdi
	movslq	%r14d,%rbx
	movq	reg_map(%rip), %rsi
	leaq	0(,%rbx,8), %r13
	cld
	subl	$56, %eax
	addq	$448, %rdi
	movslq	%eax,%rcx
	addq	$448, %rsi
	salq	$3, %rcx
	shrq	$3, %rcx
	rep
	movsq
	movl	-76(%rbp), %eax
	subl	%r14d, %eax
	cltq
	leaq	15(,%rax,8), %rsi
	andq	$-16, %rsi
	subq	%rsi, %rsp
	leaq	8(%rsp), %r12
	subq	%r13, %r12
	cmpl	-76(%rbp), %r14d
	movq	%r12, label_map(%rip)
	jge	.L179
	.p2align 4,,7
.L59:
	xorl	%eax, %eax
	incl	%r14d
	call	gen_label_rtx
	leaq	0(,%rbx,8), %r10
	addq	label_map(%rip), %r10
	cmpl	-76(%rbp), %r14d
	movq	%rax, (%r10)
	jge	.L179
	movslq	%r14d,%rbx
	jmp	.L59
	.p2align 6,,7
.L179:
	movslq	-88(%rbp),%rcx
	xorl	%eax, %eax
	cld
	salq	$3, %rcx
	leaq	15(%rcx), %r14
	shrq	$3, %rcx
	andq	$-16, %r14
	subq	%r14, %rsp
	leaq	8(%rsp), %rdi
	movq	%rdi, insn_map(%rip)
	rep
	stosq
	movq	-64(%rbp), %r11
	movq	24(%r11), %r14
	testq	%r14, %r14
	je	.L181
	.p2align 4,,7
.L173:
	movzwl	(%r14), %edx
	movq	$0, orig_asm_operands_vector(%rip)
	movq	$0, copy_asm_operands_vector(%rip)
	movzwl	%dx, %eax
	subl	$13, %eax
	cmpl	$5, %eax
	ja	.L171
	mov	%eax, %r15d
	jmp	*.L172(,%r15,8)
	.section	.rodata
	.align 8
	.align 4
.L172:
	.quad	.L72
	.quad	.L72
	.quad	.L72
	.quad	.L170
	.quad	.L169
	.quad	.L68
	.text
	.p2align 6,,7
.L68:
	cmpl	$-6, 40(%r14)
	je	.L65
	movl	$18, %edi
	xorl	%eax, %eax
	call	rtx_alloc
	movq	32(%r14), %r8
	movq	%rax, %r15
	movq	%r8, 32(%rax)
	movl	40(%r14), %eax
	movl	%eax, 40(%r15)
	.p2align 4,,7
.L67:
	movl	8(%r14), %eax
	movl	%eax, 8(%r15)
	movq	-208(%rbp), %rcx
	movslq	8(%r14),%r8
	salq	$3, %r8
	addq	insn_map(%rip), %r8
	movq	%r15, (%r8)
	movq	%r15, 24(%rcx)
	movq	%rcx, 16(%r15)
	movq	%r15, -208(%rbp)
.L65:
	movq	24(%r14), %r14
	testq	%r14, %r14
	jne	.L173
.L181:
	movq	-208(%rbp), %r10
	xorl	%eax, %eax
	movq	$0, 24(%r10)
	call	get_first_nonparm_insn
	movq	-72(%rbp), %r12
	movq	%rax, 24(%r12)
	xorl	%eax, %eax
	call	get_insns
	movq	%rax, 32(%r12)
	xorl	%eax, %eax
	movq	-48(%rbp), %r15
	movq	%r12, 136(%r15)
	call	get_frame_size
	movq	-48(%rbp), %r14
	orb	$64, 26(%r14)
	movl	%eax, 128(%r14)
	xorl	%eax, %eax
	movq	-56(%rbp), %rdi
	movq	-208(%rbp), %rsi
	movq	$0, parmdecl_map(%rip)
	movq	$0, label_map(%rip)
	movq	$0, reg_map(%rip)
	movq	$0, return_label(%rip)
	call	set_new_first_and_last_insn
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	leave
	ret
	.p2align 6,,7
.L72:
	xorl	%eax, %eax
	movzwl	%dx, %edi
	call	rtx_alloc
	leaq	32(%rax), %r9
	movq	%rax, %r15
	movq	%r9, -96(%rbp)
	movq	32(%r14), %r8
	testq	%r8, %r8
	movq	%r8, %rbx
	je	.L74
	movzwl	(%r8), %eax
	movl	%eax, -100(%rbp)
	subl	$22, %eax
	cmpl	$19, %eax
	ja	.L75
	mov	%eax, %edi
	jmp	*.L97(,%rdi,8)
	.section	.rodata
	.align 8
	.align 4
.L97:
	.quad	.L82
	.quad	.L75
	.quad	.L75
	.quad	.L95
	.quad	.L75
	.quad	.L75
	.quad	.L75
	.quad	.L75
	.quad	.L74
	.quad	.L74
	.quad	.L75
	.quad	.L74
	.quad	.L92
	.quad	.L75
	.quad	.L75
	.quad	.L84
	.quad	.L91
	.quad	.L74
	.quad	.L74
	.quad	.L74
	.text
.L82:
	movq	32(%r8), %rcx
	cmpq	%rcx, orig_asm_operands_vector(%rip)
	je	.L194
	.p2align 4,,7
.L75:
	movl	-100(%rbp), %edi
	xorl	%eax, %eax
	movq	%r8, -216(%rbp)
	call	rtx_alloc
	movq	-216(%rbp), %r8
	movq	%rax, -192(%rbp)
	movq	-192(%rbp), %rdi
	movslq	-100(%rbp),%rax
	cld
	movq	%r8, %rsi
	movq	%rax, %rdx
	movq	%rax, -112(%rbp)
	salq	$2, %rdx
	movl	rtx_length(%rdx), %eax
	incl	%eax
	cltq
	salq	$2, %rax
	movq	%rax, %rcx
	shrq	$3, %rcx
	testl	$4, %eax 
	rep
	movsq
	je	.L101
	movl	(%rsi), %eax
	movl	%eax, (%rdi)
.L101:
	movq	-112(%rbp), %r13
	movq	rtx_format(,%r13,8), %r12
	xorl	%r13d, %r13d
	cmpl	rtx_length(%rdx), %r13d
	jge	.L183
	movq	-192(%rbp), %rsi
	addq	$8, %rsi
	movq	%rsi, -120(%rbp)
	movq	%rsi, -128(%rbp)
	.p2align 4,,7
.L119:
	movsbl	(%r12),%eax
	incq	%r12
	cmpl	$101, %eax
	je	.L107
	cmpl	$101, %eax
	jg	.L118
	cmpl	$69, %eax
	je	.L109
.L104:
	movq	-112(%rbp), %rdx
	incl	%r13d
	cmpl	rtx_length(,%rdx,4), %r13d
	jl	.L119
.L183:
	cmpl	$22, -100(%rbp)
	je	.L195
.L120:
	movq	-192(%rbp), %r8
.L74:
	movq	-96(%rbp), %r9
	leaq	56(%r15), %r11
	movq	%r8, (%r9)
	movq	$0, 48(%r15)
	movl	$-1, 40(%r15)
	movq	%r11, -144(%rbp)
	movq	56(%r14), %r8
	testq	%r8, %r8
	movq	%r8, %rbx
	je	.L122
	movzwl	(%r8), %edi
	movl	%edi, %eax
	movl	%edi, -148(%rbp)
	subl	$22, %eax
	cmpl	$19, %eax
	ja	.L123
	mov	%eax, %ecx
	jmp	*.L145(,%rcx,8)
	.section	.rodata
	.align 8
	.align 4
.L145:
	.quad	.L130
	.quad	.L123
	.quad	.L123
	.quad	.L143
	.quad	.L123
	.quad	.L123
	.quad	.L123
	.quad	.L123
	.quad	.L122
	.quad	.L122
	.quad	.L123
	.quad	.L122
	.quad	.L140
	.quad	.L123
	.quad	.L123
	.quad	.L132
	.quad	.L139
	.quad	.L122
	.quad	.L122
	.quad	.L122
	.text
.L130:
	movq	32(%r8), %rsi
	cmpq	%rsi, orig_asm_operands_vector(%rip)
	je	.L196
	.p2align 4,,7
.L123:
	movl	-148(%rbp), %edi
	xorl	%eax, %eax
	movq	%r8, -216(%rbp)
	call	rtx_alloc
	movq	-216(%rbp), %r8
	movslq	-148(%rbp),%rdx
	movq	%rax, -200(%rbp)
	movq	-200(%rbp), %rdi
	cld
	movq	%r8, %rsi
	movq	%rdx, -160(%rbp)
	salq	$2, %rdx
	movl	rtx_length(%rdx), %eax
	incl	%eax
	cltq
	salq	$2, %rax
	movq	%rax, %rcx
	shrq	$3, %rcx
	testl	$4, %eax 
	rep
	movsq
	je	.L149
	movl	(%rsi), %eax
	movl	%eax, (%rdi)
.L149:
	xorl	%r13d, %r13d
	movq	-160(%rbp), %rax
	cmpl	rtx_length(%rdx), %r13d
	movq	rtx_format(,%rax,8), %r12
	jge	.L186
	movq	-200(%rbp), %rsi
	addq	$8, %rsi
	movq	%rsi, -168(%rbp)
	movq	%rsi, -176(%rbp)
	.p2align 4,,7
.L167:
	movsbl	(%r12),%eax
	incq	%r12
	cmpl	$101, %eax
	je	.L155
	cmpl	$101, %eax
	jg	.L166
	cmpl	$69, %eax
	je	.L157
.L152:
	movq	-160(%rbp), %r9
	incl	%r13d
	cmpl	rtx_length(,%r9,4), %r13d
	jl	.L167
.L186:
	cmpl	$22, -148(%rbp)
	je	.L197
.L168:
	movq	-200(%rbp), %r8
.L122:
	movq	-144(%rbp), %r13
	movq	%r8, (%r13)
	jmp	.L67
.L197:
	cmpq	$0, orig_asm_operands_vector(%rip)
	jne	.L168
	movq	-200(%rbp), %rax
	movq	32(%r8), %rdx
	movq	32(%rax), %r12
	movq	%rdx, orig_asm_operands_vector(%rip)
	movq	%r12, copy_asm_operands_vector(%rip)
	jmp	.L168
.L157:
	movq	-200(%rbp), %rdi
	movslq	%r13d,%rcx
	leaq	8(%rdi,%rcx,8), %rbx
	movq	(%rbx), %rax
	testq	%rax, %rax
	je	.L152
	movl	(%rax), %edi
	testl	%edi, %edi
	je	.L152
	leaq	8(%rax), %rsi
	movq	%r8, -216(%rbp)
	xorl	%eax, %eax
	call	gen_rtvec_v
	xorl	%r9d, %r9d
	movq	%rax, (%rbx)
	movq	-216(%rbp), %r8
	cmpl	(%rax), %r9d
	jae	.L152
	movq	%rbx, -184(%rbp)
.L163:
	movq	-184(%rbp), %rbx
	movslq	%r9d,%rsi
	xorl	%eax, %eax
	movq	(%rbx), %r11
	addq	$8, %r11
	leaq	(%r11,%rsi,8), %rbx
	movq	(%rbx), %rdi
	movl	%r9d, -224(%rbp)
	movq	%r8, -216(%rbp)
	call	copy_for_inline
	movq	%rax, (%rbx)
	movq	-184(%rbp), %r10
	movl	-224(%rbp), %r9d
	movq	(%r10), %r8
	incl	%r9d
	cmpl	(%r8), %r9d
	movq	-216(%rbp), %r8
	jb	.L163
	jmp	.L152
	.p2align 6,,7
.L166:
	cmpl	$117, %eax
	jne	.L152
	movslq	%r13d,%r12
	movq	-176(%rbp), %r13
	movq	(%r13,%r12,8), %rdx
	movslq	8(%rdx),%rax
	salq	$3, %rax
	addq	insn_map(%rip), %rax
.L190:
	movq	(%rax), %r8
	jmp	.L122
.L155:
	movq	-168(%rbp), %r9
	movslq	%r13d,%r11
	xorl	%eax, %eax
	leaq	(%r9,%r11,8), %rbx
	movq	(%rbx), %rdi
	movq	%r8, -216(%rbp)
	call	copy_for_inline
	movq	%rax, (%rbx)
	movq	-216(%rbp), %r8
	jmp	.L152
.L196:
	movl	$22, %edi
	xorl	%eax, %eax
	call	rtx_alloc
	movq	copy_asm_operands_vector(%rip), %rdx
	movq	8(%rbx), %r12
	movq	%rax, %r8
	movq	%r12, 8(%rax)
	movq	16(%rbx), %r13
	movq	%r13, 16(%rax)
	movl	24(%rbx), %eax
	movq	%rdx, 32(%r8)
	movl	%eax, 24(%r8)
	movq	40(%rbx), %r10
	movq	%r10, 40(%r8)
	jmp	.L122
.L143:
	movq	8(%r8), %rax
	cmpw	$34, (%rax)
	jne	.L123
	movl	8(%rax), %eax
	cmpl	max_parm_reg(%rip), %eax
	jge	.L123
	cmpl	$55, %eax
	jle	.L123
	cltq
	salq	$3, %rax
	addq	parmdecl_map(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L123
	andb	$-33, 25(%rax)
	jmp	.L123
	.p2align 6,,7
.L140:
	movl	8(%r8), %eax
	cmpl	$55, %eax
	jle	.L122
	cltq
	salq	$3, %rax
	addq	reg_map(%rip), %rax
	jmp	.L190
.L132:
	movq	8(%r8), %rcx
	movzwl	(%rcx), %edx
	leal	-38(%rdx), %ebx
	cmpw	$1, %bx
	jbe	.L122
	cmpw	$30, %dx
	je	.L122
	cmpw	$32, %dx
	je	.L122
	cmpw	$44, %dx
	jne	.L123
	movq	8(%rcx), %rax
	cmpw	$34, (%rax)
	jne	.L123
	cmpl	$14, 8(%rax)
	jne	.L123
	movq	16(%rcx), %r9
	movzwl	(%r9), %edx
	leal	-38(%rdx), %r11d
	cmpw	$1, %r11w
	jbe	.L136
	cmpw	$30, %dx
	je	.L136
	cmpw	$32, %dx
	jne	.L123
.L136:
	cmpw	$34, (%rcx)
	jne	.L123
	cmpl	$14, 8(%rcx)
	jne	.L123
	movq	16(%r8), %rcx
	movzwl	(%rcx), %edx
	leal	-38(%rdx), %edi
	cmpw	$1, %di
	jbe	.L122
	cmpw	$30, %dx
	je	.L122
	cmpw	$32, %dx
	jne	.L123
	jmp	.L122
	.p2align 6,,7
.L139:
	movq	8(%r8), %r10
	movzbl	2(%r8), %esi
	movl	$38, %edi
	xorl	%eax, %eax
	movslq	32(%r10),%r8
	salq	$3, %r8
	addq	label_map(%rip), %r8
	movq	(%r8), %rdx
	call	gen_rtx
	movq	%rax, %r8
	jmp	.L122
.L195:
	cmpq	$0, orig_asm_operands_vector(%rip)
	jne	.L120
	movq	-192(%rbp), %r12
	movq	32(%r8), %rbx
	movq	32(%r12), %r13
	movq	%rbx, orig_asm_operands_vector(%rip)
	movq	%r13, copy_asm_operands_vector(%rip)
	jmp	.L120
.L109:
	movq	-192(%rbp), %r9
	movslq	%r13d,%rdi
	leaq	8(%r9,%rdi,8), %rbx
	movq	(%rbx), %rax
	testq	%rax, %rax
	je	.L104
	movl	(%rax), %edi
	testl	%edi, %edi
	je	.L104
	leaq	8(%rax), %rsi
	movq	%r8, -216(%rbp)
	xorl	%eax, %eax
	call	gen_rtvec_v
	xorl	%r9d, %r9d
	movq	%rax, (%rbx)
	movq	-216(%rbp), %r8
	cmpl	(%rax), %r9d
	jae	.L104
	movq	%rbx, -136(%rbp)
.L115:
	movq	-136(%rbp), %rax
	movslq	%r9d,%rsi
	movq	(%rax), %r10
	xorl	%eax, %eax
	addq	$8, %r10
	leaq	(%r10,%rsi,8), %rbx
	movq	(%rbx), %rdi
	movl	%r9d, -224(%rbp)
	movq	%r8, -216(%rbp)
	call	copy_for_inline
	movq	%rax, (%rbx)
	movq	-136(%rbp), %rcx
	movl	-224(%rbp), %r9d
	movq	(%rcx), %r8
	incl	%r9d
	cmpl	(%r8), %r9d
	movq	-216(%rbp), %r8
	jb	.L115
	jmp	.L104
	.p2align 6,,7
.L118:
	cmpl	$117, %eax
	jne	.L104
	movq	-128(%rbp), %r11
	movslq	%r13d,%rbx
	movq	(%r11,%rbx,8), %r12
	movslq	8(%r12),%rax
	salq	$3, %rax
	addq	insn_map(%rip), %rax
.L189:
	movq	(%rax), %r8
	jmp	.L74
.L107:
	movq	-120(%rbp), %r10
	movslq	%r13d,%rdx
	xorl	%eax, %eax
	leaq	(%r10,%rdx,8), %rbx
	movq	(%rbx), %rdi
	movq	%r8, -216(%rbp)
	call	copy_for_inline
	movq	%rax, (%rbx)
	movq	-216(%rbp), %r8
	jmp	.L104
.L194:
	movl	$22, %edi
	xorl	%eax, %eax
	call	rtx_alloc
	movq	copy_asm_operands_vector(%rip), %r12
	movq	8(%rbx), %rsi
	movq	%rax, %r8
	movq	%rsi, 8(%rax)
	movq	16(%rbx), %r13
	movq	%r13, 16(%rax)
	movl	24(%rbx), %eax
	movq	%r12, 32(%r8)
	movl	%eax, 24(%r8)
	movq	40(%rbx), %rdx
	movq	%rdx, 40(%r8)
	jmp	.L74
.L95:
	movq	8(%r8), %rax
	cmpw	$34, (%rax)
	jne	.L75
	movl	8(%rax), %eax
	cmpl	max_parm_reg(%rip), %eax
	jge	.L75
	cmpl	$55, %eax
	jle	.L75
	cltq
	salq	$3, %rax
	addq	parmdecl_map(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L75
	andb	$-33, 25(%rax)
	jmp	.L75
	.p2align 6,,7
.L92:
	movl	8(%r8), %eax
	cmpl	$55, %eax
	jle	.L74
	cltq
	salq	$3, %rax
	addq	reg_map(%rip), %rax
	jmp	.L189
.L84:
	movq	8(%r8), %rcx
	movzwl	(%rcx), %edx
	leal	-38(%rdx), %ebx
	cmpw	$1, %bx
	jbe	.L74
	cmpw	$30, %dx
	je	.L74
	cmpw	$32, %dx
	je	.L74
	cmpw	$44, %dx
	jne	.L75
	movq	8(%rcx), %rax
	cmpw	$34, (%rax)
	jne	.L75
	cmpl	$14, 8(%rax)
	jne	.L75
	movq	16(%rcx), %r11
	movzwl	(%r11), %edx
	leal	-38(%rdx), %r10d
	cmpw	$1, %r10w
	jbe	.L88
	cmpw	$30, %dx
	je	.L88
	cmpw	$32, %dx
	jne	.L75
.L88:
	cmpw	$34, (%rcx)
	jne	.L75
	cmpl	$14, 8