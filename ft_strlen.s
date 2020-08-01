;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strlen.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/03/20 15:20:02 by juligonz          #+#    #+#              ;
;    Updated: 2020/03/29 19:57:45 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

global _ft_strlen

_ft_strlen:
	cld				; clear direction flag before use of repne instruction. Not really usefull, but safer. (if the caller has set the flag)
	mov rcx, -1	 	; to set all the bits to true. (same as 0xffffffff)
	mov rsi, rdi	; keep the start of the string in rsi
	mov al, 0   	; move 0 in %al. %al is used by scasb instruction
	repne scasb 	; REpeat While Not Equal to %al-> SCAn String Byte (1 octet) 
	sub rdi, rsi	; calculate the len (sub result is stored in the first register (rdi))
	dec rdi     	; decrement one to not count '\0'
	mov rax, rdi	; return len using %rax (%rax is used as return register, like rdx, xmm0, etc))
	ret