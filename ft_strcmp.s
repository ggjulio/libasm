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
DEFAULT REL

	global _ft_strcmp

	section .data
var: dd 14

	section .text
_ft_strcmp:
	; cld
	; mov rcx, -1
	; mov rax, [rdi]
	; repe cmpsb
	; sub   al,  si
	; mov rax, al

	mov rdi, 20
	; mov [var], byte rdi
	mov rax, [var]
	ret

	; cld
	
	; repe cmpsb 
	; sub , [rsi -rcx]
	; mov rax, BYTE rdi
	; ret