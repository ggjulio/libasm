;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_atoi_base.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/06 00:39:44 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/06 00:39:46 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%pragma macho gprefix _

section .text
	global ft_atoi_base



ft_atoi_base:
	ret


ft_isspace:
	mov rax, rdi
	mov rdi, " \f\n\r\t\v"
	mov rcx, 6
	repne scasb
	jz .false
	mov rax, 1
	ret
	.false:
		mov rax, 0
		ret