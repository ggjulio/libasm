;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    hello.s                                            :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/03/20 15:20:02 by juligonz          #+#    #+#              ;
;    Updated: 2020/03/20 16:22:32 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;


section .data
		text db "Hello, World!", 10	; Define Bite, and 10 equal new line
	
section .text
	global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov	rsi, text
	mov	rdx, 14
	syscall

	mov rax, 60
	mov rdi, 0
	syscall
