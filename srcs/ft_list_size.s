;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_size.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/10 13:34:13 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/10 13:34:59 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%include "libasm.inc"

section .text
	global ft_list_size

ft_list_size: ; ft_list_size(t_list *begin_list)
	mov rax, 0
	.loop:
		test rdi, rdi
		jz .end
		mov rdi, qword [rdi + 8] 
		add rax, 1
		jmp .loop
	.end:
		ret
