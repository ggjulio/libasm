;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_write.s                                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/05 21:27:41 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/05 21:27:43 by juligonz         ###   ########.fr        ;
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
	global ft_write

ft_write:
	mov rax, SYS_WRITE
	syscall
	ret
