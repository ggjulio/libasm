;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcmp.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/06/03 20:48:59 by juligonz          #+#    #+#              ;
;    Updated: 2020/06/03 20:49:00 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

global ft_strcmp

ft_strcmp:
	cld
	mov rcx, -1
	mov   al, BYTE [rdi]
	repe cmpsb
	sub   al,  [si]
	movsx rax, al
	ret


	; cld
	
	; repe cmpsb 
	; sub , [rsi -rcx]
	; mov rax, BYTE rdi
	; ret