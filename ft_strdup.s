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

section .text
    global _ft_strdup
    extern _ft_strlen
    extern _ft_strcpy
    extern _malloc


_ft_strdup:
    push rdi

    call _ft_strlen
    add rax, 1    
    mov rdi, rax

    call _malloc
    test rax, rax


    pop rdi

    jz .fail

    .fail:
        mov rax, 0
    ret