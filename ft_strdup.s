;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strdup.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/04 19:28:39 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/04 19:28:40 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%pragma macho gprefix _

section .text
    global ft_strdup
    extern ft_strlen
    extern ft_strcpy
    extern malloc

ft_strdup:
    push rdi

    call ft_strlen
    add rax, 1    
    mov rdi, rax

    call ft_malloc
    test rax, rax
    jz .end         ;   malloc failed, returning NULL

    mov rdi, rax
    pop rsi
    call ft_strcpy
.end:
    ret