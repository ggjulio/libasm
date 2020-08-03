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

	section .text
	global _ft_strcmp

_ft_strcmp:
	xor rcx, rcx
	.loop:
		xor rax, rax
		mov byte rax, rdi
		sub al, sil
		inc rdi
		inc rsi
		jz .loop

		add rcx, 1
	jmp .loop

		ret