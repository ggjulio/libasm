;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_push_front.s                               :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/07 14:26:43 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/07 14:26:43 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%include "libasm.inc"

default rel 

section .text
	global ft_list_push_front
	extern ft_create_elem

ft_list_push_front: ; rdi: **begin_list, rsi: *data 
	push rdi
	mov rdi, rsi ;  *data 
	call ft_create_elem
	pop rdi
	; test rax, ra
	mov rbx, [rdi]
	mov qword [rax + 8], rbx
	mov [rdi], rax
.end
	ret

	global ft_list_remove_if
	global ft_list_size
	global ft_list_sort

ft_list_remove_if:
ft_list_size:
ft_list_sort:
	xor rcx,rcx
	xor rax,rax
	xor rdi,rdi
	xor rsi,rsi
ret
