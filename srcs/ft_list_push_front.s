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

section .text
	global ft_list_push_front
	extern ft_create_elem

ft_list_push_front:			 ; rdi: **begin_list, rsi: *data 
	push rdi
	mov rdi, rsi
	call ft_create_elem
	pop rdi
	test rax, rax
	jz .end					 ; malloc failed-> return;
	mov rbx, [rdi]
	test rbx, rbx
	jz .list_null 			 ; list null -> jump to .list_null
	mov qword [rax + 8], rbx ; otherwise -> new->next = *begin_list 
	mov [rdi], rax			 ; begin_list = new;
.end:
	ret

.list_null:
	mov [rdi], rax
	ret




	global ft_list_sort
ft_list_sort:
	xor rcx,rcx
	xor rax,rax
	xor rdi,rdi
	xor rsi,rsi
ret
