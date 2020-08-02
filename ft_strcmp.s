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
		; cmp rsi, 0
		; jz .end
		cmp dil, [sil]
		jne .end

		add rcx, 1
	jmp .loop

	.end:
		sub rsi, rdi
		mov rax, rsi
		mov rax, rcx
		ret