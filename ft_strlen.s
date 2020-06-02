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
        mov rcx, -1	 ; to set all the bits to true. (same as 0xffffffff)
        mov rsi, rdi ; backup rdi
        mov al, 0    ; look for \0
        repne scasb  ; actually do the search
        sub rdi, rsi ; save the string length
        dec rdi      ; don't count the \0 in the string length
        mov rax, rdi ; save the return value
        ret