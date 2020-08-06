;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_read.s                                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/05 22:29:59 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/05 22:30:01 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%pragma macho gprefix _

%ifdef MACHO64
	%define SYS_READ  0x2000003
	%define SYS_WRITE 0x2000004
%else
	%define SYS_READ 0
	%define SYS_WRITE 1
%endif

section .text
	global ft_read

ft_read:
	mov rax, SYS_READ
	syscall
	ret
