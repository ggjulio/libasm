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

%include "libasm.inc"

section .text
	global ft_write
	extern SYM_ERRNO

ft_write:
	mov rax, SYS_WRITE
	syscall
	jnc .end
	push rax
	call SYM_ERRNO
	pop qword [rax]
	mov rax, -1
.end:
	ret