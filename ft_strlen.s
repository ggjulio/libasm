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

global ft_strlen

ft_strlen:
		mov rcx, -1	 	; to set all the bits to true. (same as 0xffffffff)
		mov rsi, rdi
		mov al, 0   	; move 0 in %al. %al is used by scasb instruction
		repne scasb 	; REpeat While Not Equal -> SCAn String Byte (1 octet) 
		sub rdi, rsi	; calculate the len (result of the sub is stored in the first register (rdi))
		dec rdi     	; decrement to not count '\0'
		mov rax, rdi	; return len using %rax (%rax is used as return register, like rdx, xmm0, etc))
		ret