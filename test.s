;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    test.s                                             :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/03 18:25:16 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/03 18:25:33 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

DEFAULT REL 

STDIN equ 0
STDOUT equ 1

OSX_SYS_READ equ "NULL"
OSX_SYS_WRITE equ 0x2000004
OSX_SYS_EXIT equ 0x2000001

ELF_SYS_READ equ 0
ELF_SYS_WRITE equ 1
ELF_SYS_EXIT equ 60

section .data
	texte		db "abcd",10,10,10,0
	text	db 0,0,0,0,0

section .text
    global _main
_main:
	mov rax, OSX_SYS_WRITE
	mov rdi, 1
	lea rsi, texte 
	mov rdx, 6
	syscall

	mov rax, OSX_SYS_EXIT
	mov rdi, 0
	syscall
