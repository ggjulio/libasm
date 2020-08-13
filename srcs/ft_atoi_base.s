;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_atoi_base.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/06 00:39:44 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/06 00:39:46 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%include "libasm.inc"

section .data
	base_string:  dq 0
	base_size: dq 0
	sign: db 0

section .text
	global ft_atoi_base
	extern ft_isspace
	extern ft_strlen

; int		ft_atoi_base(char *str, char *base)
ft_atoi_base:
	; check if both of string are not empty
	cmp byte [rdi], 0
	je	.error
	cmp byte [rsi], 0
	je	.error
	push r12
	push r13
	push r14

	lea r12, [rdi]	; str string
	xor r13, r13	; index of str
	xor r14, r14	; result
	.skip_spaces:
		mov rdi, [rel r12 + r13]
		call ft_isspace
		test rax, rax
		jz .skip_sign
		add r13,1
	jmp .skip_spaces
	.skip_sign:
	; mov rdi, rsi
	; call ft_strlen
	; mov qword [base_size], rax

.end:
	pop r14
	pop r13
	pop r12
	ret
.error:
	mov rax, 0
	ret
