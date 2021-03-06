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
cmp qword [rdi], 0
jne .list_not_null
	ret
.list_not_null:
	push r12	; previous element
	push r13	; actual
	push r14	; next
	mov qword [begin_list]		, rdi
	mov qword [func_cmp]		, rsi
	xor r12, r12		; r12 == previous element
	mov r13, [rdi]		; r13 == actual element
	mov r14, [r13 + 8]	; r14 == next element

	.loop:
	test r14, r14		; if no next element, go to end
	jz .end
		mov rdi, qword [r13]
		mov rsi, qword [r14]
		call qword [func_cmp]
		cmp rax, 0
		jg .do_swap
			mov r12, r13				; previous = actual
			mov r13, qword [r13 + 8]	; actual = actual->next
			mov r14, qword [r13 + 8]	; next = actual->next
	jmp .loop

		.do_swap:
		test r12, r12
		jz .previous_null
			mov r15, qword [r13 + 8]
			mov qword[r12 + 8], r15		; previous->next = actual->next;
		jmp .end_swap
		.previous_null:
			mov rax, qword [begin_list]
			mov r15, [r13 + 8]
			mov qword [rax] ,  r15		; *begin_list = actual->next
		.end_swap:
			mov r15, qword [r14 + 8]
			mov qword [r13 + 8], r15		; actual->next = next->next;
			mov qword [r14 + 8], r13		; next->next = actual;
		.reset_actual_to_begin_list:
			xor r12, r12
			mov r13, qword [begin_list]
			mov r13, [r13]
			mov r14, [r13 + 8]
	jmp .loop

.end:
	pop r14
	pop r13
	pop r12
	ret
