;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    hello.s                                            :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/03/20 15:20:02 by juligonz          #+#    #+#              ;
;    Updated: 2020/03/27 02:11:12 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;


section .data
	text1 db "What is your name ?", 10
	text2 db "Hello, "
	
section .bss
	name resb 16
	
section .text
	global _start


%macro exit 0
	mov rax, 60
	mov rdi, 0
	syscall
%endmacro

_start:
	call _printText1
	call _getName
	call _printText2
	call _printName
	exit
	
_printText1:
	mov rax, 1
	mov rdi, 1
	mov rsi, text1
	mov rdx, 20
	syscall
	ret

_getName:
	mov rax, 0
	mov rdi, 0
	mov rsi, name
	syscall
	ret
	
_printText2:
	mov rax, 1
	mov rdi, 1
	mov rsi, text2
	mov rdx, 7
	syscall
	ret

	
_printName:
	mov rax, 1
	mov rdi, 1
	mov rsi, name
	mov rdx, 16
	syscall
	ret

