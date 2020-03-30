;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    hello.s                                            :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/03/20 15:20:02 by juligonz          #+#    #+#              ;
;    Updated: 2020/03/29 18:14:17 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;


section .data
	digit db 7, 10
	
section .text
	global _start

_start:
	mov rax, 6
	mov rbx, 1
	div rbx
	call _printRAXDigit
	mov rax, 60
	mov rdi, 0
	syscall

	
_printRAXDigit:
	add rax, 48
	mov [digit], al
	mov rax, 1
	mov rdi, 1
	mov rsi, digit
	mov rdx, 2
	syscall
	ret