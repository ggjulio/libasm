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

; int		ft_atoi_base(char *str, char *base)
ft_atoi_base:
	; check if both of string are not empty
	; cmp byte [rdi], 0
	; je	.error
	; cmp byte [rsi], 0
	; je	.error

	push r12
	push r13
	push r14
	push r15

	lea r12, [rdi]						; str string
	mov qword [rel base_string], rsi 	; save base string
	xor r13, r13						; index of str
	xor r14, r14						; result
	xor r15, r15						; sign

	mov rdi, rsi
	call ft_strlen
	mov qword [rel base_size], rax 	;;;; get len base

	.skip_spaces:
		mov dil, [rel r12 + r13]
		call ft_isspace
		test rax, rax
		jz .skip_sign
		add r13, 1 		; increment string index
	jmp .skip_spaces

	.skip_sign:
		mov dil, byte [rel r12 + r13]
		call is_sign
		test rax, rax 
	jz .do_op
		add r13, 1		; increment string index 
		cmp dil, '-'
	jne .skip_sign
		add r15, 1 		; increment sign count
	jmp .skip_sign


.do_op:
		mov dil, [rel r12 + r13]
		cmp dil, 0		; check null byte
	jz .end
		mov rsi, [rel base_string] ; ???????????????????????????????????
		call get_index	; int	get_index(char c, char *base)
		cmp rax, -1		; check get_index has found the character
	je .end
		push rax
			mov rax, qword [rel base_size]
			mul r14
		mov r14, rax
		pop rax
		add r14, rax
		mov dil, byte [rel r12 + r13]

		add r13, 1 ; increment string
jmp .do_op

.end:
	mov rax, r14 ; return result
	pop r15
	pop r14
	pop r13
	pop r12
ret
; .error:
; 	mov rax, 0
; ret

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


