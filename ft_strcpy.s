;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcpy.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/06/03 20:48:59 by juligonz          #+#    #+#              ;
;    Updated: 2020/06/03 20:49:00 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%pragma macho gprefix _

	section .text
	extern ft_strlen
	global ft_strcpy

ft_strcpy:
	push rdi		; save dest ptr to the stack
	mov rdi, rsi	; to call strlen on src, we put the src pointer in rdi 
	call ft_strlen	; and call ft_strlen to get the len of src
	pop rdi			; restore the dest string pointer into rdi
	mov rcx, rax 	; mov the len of src into the counter register
	inc rcx			; increment 1 to copy '\0'
	rep movsb	 	; REPeat while ecx != 0 -> MOVe String Byte from rsi to rdi (1 octet) 
	ret
