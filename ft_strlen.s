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

_strlen:

  push  rcx            ; save and clear out counter
  xor   rcx, rcx

_strlen_next:

  cmp   [rdi], byte 0  ; null byte yet?
  jz    _strlen_null   ; yes, get out

  inc   rcx            ; char is ok, count it
  inc   rdi            ; move to next char
  jmp   _strlen_next   ; process again

_strlen_null:

  mov   rax, rcx       ; rcx = the length (put in rax)

  pop   rcx            ; restore rcx
  ret