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

section .data
	str:  dq 0
	base: dq 0

section .text
	global ft_atoi_base

	extern ft_isspace
	extern ft_strlen

ft_atoi_base:
	mov qword [str], rdi
	mov rdi, rsi
	call ft_strlen
	mov qword [base], rax
	lea rax, [str]

	ret
