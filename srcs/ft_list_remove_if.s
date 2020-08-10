;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_remove_if.s                                :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/10 14:35:36 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/10 14:35:41 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%include "libasm.inc"

section .text
	global ft_list_remove_if
	extern free
;t_list **begin_list, void *data_ref, int (*cmp)()	, void (*free_fct)(void *))	;
;		rdi			,		rsi		,		rdx		,			rcx				;

ft_list_remove_if:
	xor r12, r12 	;		r12 == previous == NULL
	mov r13, [rdi]	;		r13 == actual (and first elem now)
	mov r14, rdi	;		r14 == **begin_list
	.loop:
	test r13, r13
	jz .end
		mov rdi, qword [r13]	; arg1 == actual data elem, arg2 (rsi) data_ref 
		call rdx				; call int cmp()
		test rax, rax
		jz .delete
			mov r12, r13				; previous = actual
			mov r13, qword [r13 + 8] 	; actual = actual->next
			jmp .loop
		.delete:
			test r12, r12
			jz .previous_null
				mov r15, [r12 + 8]
				mov r15, [r13 + 8]		; previous->next = actual->next;
			jmp free
			.previous_null:
				mov r14, [r13 + 8]
			.free:
				mov rdi, [r13 + 8]
				call rcx			; free actual->data
				mov rdi, [r13]
				call free
		mov r13, qword [r13 + 8] 	; actual = actual->next
	jmp .loop

.end:
	ret
