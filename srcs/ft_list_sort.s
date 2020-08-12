;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_sort.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/12 15:37:23 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/12 15:37:24 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%include "libasm.inc"

section .data
	begin_list dq 0
	func_cmp dq 0

section .text
	global ft_list_sort

;ft_list_sort(t_list **begin_list, int (*cmp)());
ft_list_sort:
	push r12	; previous element
	push r13	; actual
	push r14	; next
	mov qword [rel begin_list]		, rdi
	mov qword [rel func_cmp]		, rsi
	xor r12, r12		; r12 == previous element
	mov r13, [rdi]		; r13 == actual element
	mov r14, [r13 + 8]	; r14 == next element
	.loop:
	test r14, r14		; if no next element, go to end
	jz .end
		mov rdi, qword [r13]
		mov rsi, qword [r14]
		call qword [rel func_cmp]
		test rax, rax
		jl .do_swap
			mov r12, r13				; previous = actual
			mov r13, qword [r13 + 8]	; actual = actual->next
			mov r14, qword [r13 + 8]	; next = actual->next
	jmp .loop
		.do_swap:
		test r12, r12
		jz .previous_null
			lea rax, qword [rel r12 + 8]
			mov r15, qword [rel r13 + 8]
			mov qword [rax], r15		; previous->next = actual->next;
		jmp .end_swap
		.previous_null:
			mov rax, qword [rel begin_list]
			mov r15, [rel r13 + 8]
			mov qword [rax] ,  r15		; *begin_list = actual->next
		.end_swap:
			lea rax, qword [rel r13 + 8]
			mov r15, qword [rel r14 + 8]
			mov qword [rax], r15		; actual->next = next->next;
			
			lea rax, qword [rel r14 + 8]
			mov r15, qword [rel r13]
			mov qword [rax], r15		; next->next = actual;
		.reset_actual_to_begin_list:
			xor r12, r12
			mov r13, qword [rel begin_list]
			mov r13, r13
			mov r14, [r13 + 8]
	jmp .loop

.end:
	pop r14
	pop r13
	pop r12
	ret
