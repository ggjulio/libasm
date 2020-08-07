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
	arg1:  dq 0
	arg2:  dq 0
	base_size: dq 0
	sign: db 0

section .text
	global ft_atoi_base

	extern ft_isspace
	extern ft_strlen
	default rel

ft_atoi_base:
	; check if both of string are not empty
	cmp byte [rdi], 0
	je	.error
	cmp byte [rsi], 0
	je	.error

	; save args to memory before call function
	; lea rdx, [arg1]
	; mov  [rdx], rdi
	; lea rdx,  arg2
	; mov [rdx], rsi
	
	mov rdi, rsi
	call ft_strlen
	mov qword [base_size], rax


	.test:
	mov r10, [base_size]
	lea rax, arg1

	mov r10, [base_size]
	ret


	.error:
		mov rax, -1
		ret