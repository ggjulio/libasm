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

%include "libasm.inc"

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

    call malloc wrt ..plt
    test rax, rax
    pop rsi         ; pop the src as arg2 of ft_strcpy
    jz .end         ; if malloc failed, return NULL

    mov rdi, rax    ; mov dest ptr as arg1
    call ft_strcpy
.end:
    ret
