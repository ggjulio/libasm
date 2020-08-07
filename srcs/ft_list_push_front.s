;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_push_front.s                               :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/07 14:26:43 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/07 14:26:43 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%include "libasm.inc"

default rel

struc liste
	data resq 1
	next resq 1
endstruc

section .text
	global ft_list_push_front

ft_list_push_front:
	lea r10, [rdi]
	lea r10, [r10]
	ret
