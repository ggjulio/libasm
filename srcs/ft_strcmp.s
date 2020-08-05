;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcmp.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/06/03 20:48:59 by juligonz          #+#    #+#              ;
;    Updated: 2020/06/03 20:49:00 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%pragma macho gprefix _

section .text
	global ft_strcmp

ft_strcmp:
	.loop:
		movzx rax, byte [rdi]		; same as -> xor rax, rax | mov al, [rdi]
		movzx rcx, byte [rsi]
		sub rax, rcx
		jnz .end
		cmp byte [rdi], 0
		je .end
		inc rdi
		inc rsi
		jmp .loop
	.end:
		ret