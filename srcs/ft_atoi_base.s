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

%pragma macho gprefix _

DEFAULT REL

section .data
	str:  dq 0 ; save str ptr instead of push to the stack
	base_size: dq 0
	sign: db 0

section .text
	global ft_atoi_base

	extern ft_isspace
	extern ft_strlen

ft_atoi_base:
	; check if both of string are not empty
	cmp byte [rdi], 0
	je	.error
	cmp byte [rsi], 0
	je	.error

	mov rcx, 0

	mov qword[str], rdi
	mov rdi, rsi
	call ft_strlen
	mov qword [base_size], rax
	mov r10, [base_size]
	lea rax, [str]

	mov r10, [base_size]
	ret


	.error:
		mov rax, -1
		ret