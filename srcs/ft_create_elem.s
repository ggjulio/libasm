;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_create_elem.s                                   :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/09 16:07:45 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/09 16:08:15 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%include "libasm.inc"

section .text
	global ft_create_elem
	extern malloc

ft_create_elem:
	mov rbx, rdi
	mov rdi, 16
	call malloc
	test rax, rax
	jz .end			; malloc failed -> jump end
	mov qword [rax], rbx
	mov qword [rax + 8], 0
.end:
	ret
