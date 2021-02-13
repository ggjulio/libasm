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

%include "libasm.inc"

section .text
	global ft_read
	extern SYM_ERRNO

ft_read:
	mov rax, SYS_READ
	syscall

	%ifdef MACHO64
		jnc .end
		push rax
		call SYM_ERRNO
		pop qword [rax]
	%else
		cmp rax, 0
		jge .end
		push rax
		call SYM_ERRNO wrt ..plt
		pop qword [rax]
		neg qword [rax]		
	%endif

	mov rax, -1
.end:
	ret
