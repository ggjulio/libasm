;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_atoi_base.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/06 00:39:44 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/06 00:39:46 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%include "libasm.inc"

section .data
	base_size: dq 0
	base_string: dq 0

section .text
	global ft_atoi_base
	extern ft_isspace
	extern ft_strlen
	extern ft_strchr

; int		ft_atoi_base(char *str, char *base)
ft_atoi_base:
	cmp rdi, 0
	je    .error
	cmp rsi, 0
	je    .error
	push r12
	push r13
	push r14
	push r15
	mov qword [base_string], rsi 	; save base string
	lea r12, [rdi]						; r12 = str
	xor r13, r13						; r13 = index of str
	xor r14, r14						; r14 = result
	xor r15, r15						; r15 = sign

	mov rdi, rsi
	call check_base
	test rax, rax
	je .end
	
	mov qword [base_size], rax 	; save base len
	.skip_spaces:
		mov dil, [r12 + r13]
		call ft_isspace
		test rax, rax
		jz .skip_sign
		add r13, 1 		; increment string index
	jmp .skip_spaces
	.skip_sign:
		mov dil, byte [r12 + r13]
		call is_sign
		test rax, rax 
		jz .do_op
		add r13, 1		; increment string index 
		cmp dil, '-'
	jne .skip_sign
		add r15, 1 		; increment sign count
	jmp .skip_sign
	.do_op:
		mov dil, [r12 + r13]
		cmp dil, 0		; check null byte
		jz .do_sign
		mov rsi, [base_string]
		call get_index
		cmp rax, -1		; check if get_index has found the character
		je .do_sign
		push rax	; push the index
		mov rax, qword [base_size]
		mul r14
		mov r14, rax	; multiply the result by the base
		pop rax
		add r14, rax	; add the index to actual result
		add r13, 1 ; increment string
	jmp .do_op
	.do_sign:
		mov rax, r14 ; mov result in rax
		test r15, 1
		jz .end
		neg rax
	.end:
		pop r15
		pop r14
		pop r13
		pop r12
	ret
	.error:
		mov rax, 0
	ret

; ---------------------- ;
;         Helpers        ;
; ---------------------- ;

;return 1 if is sign else 0
is_sign:
		mov rax, 1
		cmp dil, '-'
	je .end
		cmp dil, '+'
	je .end
		mov rax, 0
	.end:
		ret

;return -1 if is not an index, else, return the index
; int		get_index(char c, char *base)
get_index:
	xor rcx, rcx
	.loop:
		cmp byte [rsi + rcx], 0
		jz .index_not_found
		cmp dil, byte [rsi + rcx]
		je .end
		inc rcx
	jmp .loop
	.index_not_found:
		mov rax, -1
		ret
	.end:
		mov rax, rcx
		ret

;
;int		check_base(char *str_base)
check_base:
	push r12
	push r13
	mov r12, rdi
	xor r13, r13
	.loop:
		mov dil, [r12 + r13]
		test dil, dil
		jz .done			; end loop at '\0'
		cmp dil, '+'
		je .error
		cmp dil, '-'
		je .error		; error if + or - 
		call ft_isspace
		cmp rax, 0
		jg .error		; error if character is space
		lea rdi, [r12 + r13 + 1]
		mov rsi, [r12 + r13]
		call ft_strchr
		test rax, rax
		jnz .error		; error if dupplicate character
	inc r13
	jmp .loop
	.error:
		mov rax, 0
		jmp .end
	.done:
		mov rax, r13		
	.end:
		pop r13
		pop r12
	ret










