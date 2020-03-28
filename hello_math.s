;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    hello.s                                            :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/03/20 15:20:02 by juligonz          #+#    #+#              ;
;    Updated: 2020/03/28 09:04:35 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;


section .data
	digit db 5, 10
	
section .text
	global _start

_start:
	
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
