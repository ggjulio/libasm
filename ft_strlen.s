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
 	push rcx		; save rcx to the stack, to respect fascall convention
	mov rcx, 0		; reset rcx to 0

_strlen_next:
	cmp   [rdi], BYTE 0  ; is null byte ? 
	jz    _strlen_null   ; if yes, break the loop	
	inc   rcx            ; char is ok, count it
	inc   rdi            ; move to next char
	jmp   _strlen_next   ; process again	

_strlen_null:
	mov   rax, rcx     ; we move rcx (the lenght) into rax, because, 
	pop   rcx            ; we pop rcx
	ret
