;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcpy.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/06/03 20:48:59 by juligonz          #+#    #+#              ;
;    Updated: 2020/06/03 20:49:00 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

extern ft_strlen

global ft_strcpy

ft_strcpy:
	push rdi		; save dest str to the stack
	mov rdi, rsi	; put src str to rdi
	call ft_strlen	; and call ft_strlen to get the len of src string
	pop rdi			; restore the dest string
	mov rcx, rax 	; mov the len of src into the counter register
	dec rcx
	rep movsb	 	; REpeat While Not Equal to %al-> MOVe String Byte (1 octet) 
	ret
