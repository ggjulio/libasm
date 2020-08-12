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

section .data
	begin_list dq 0
	data_ref dq 0
	func_cmp dq 0
	func_free_fct dq 0

section .text
	global ft_list_remove_if
	extern free
;t_list **begin_list, void *data_ref, int (*cmp)()	, void (*free_fct)(void *))	;
;		rdi			,		rsi		,		rdx		,			rcx				;

ft_list_remove_if:
	push r12
	push r13
	push r15
	
	mov qword [rel begin_list]		, rdi
	mov qword [rel data_ref]		, rsi	
	mov qword [rel func_cmp]		, rdx	
	mov qword [rel func_free_fct]	, rcx	
	xor r12, r12 	;		r12 == previous == NULL
	mov r13, [rdi]	;		r13 == actual (and first elem now)

	.loop:
	test r13, r13
	jz .end
		mov rdi, qword [r13]	; arg1 == actual data elem 
		mov rsi, qword [rel data_ref] 
		call qword [rel func_cmp]
		test rax, rax
		jz .delete_element
			; not equal, so increment and jmp loop
			mov r12, r13				; previous = actual
			mov r13, qword [r13 + 8] 	; actual = actual->next
	jmp .loop

		.delete_element:
			test r12, r12
			jz .previous_null
				mov r15, [rel r12 + 8]
				mov rax, [rel r13 + 8]
				mov r15, rax		; previous->next = actual->next;
			jmp .do_free
			.previous_null:			; *begin_list = actual->next
				mov rax, qword [rel begin_list]
				mov r15, [rel r13 + 8]
				mov qword [rax] ,  r15
			.do_free:
				; mov rdi, [r13 + 8]
				; call rcx			; free actual->data
				; mov rdi, [r13]
				; call free
		mov r13, qword [r13 + 8] 	; actual = actual->next
	jmp .loop

.end:
	pop r15
	pop r14
	pop r13
	ret
