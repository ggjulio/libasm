;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    hello_print_int.s                                  :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/03/30 19:06:33 by juligonz          #+#    #+#              ;
;    Updated: 2020/03/31 07:29:11 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

section .bss
	digitSpace resb 100
	digitSpacePos resb 8

section .text
	global _start

_start:
	mov rax, 123
	call _printRAX

	mov rax, 60
	mov rdi, 0
	suscall
	

_printRAX:
	mov rcx, digitSpace
	mov rbx, 10
	
