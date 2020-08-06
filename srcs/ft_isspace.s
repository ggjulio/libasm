;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_isspace.s                                       :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/06 01:55:24 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/06 01:55:26 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%pragma macho gprefix _

section .data
	spaces: db ` \f\n\r\t\v`

section .text
	global ft_isspace

ft_isspace:
	cld
	movzx rax, dil
	mov rdi, spaces
	mov rcx, 6
	repne scasb
	jz .end
	mov rax, 0
.end:
	ret
