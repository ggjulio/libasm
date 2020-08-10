;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_remove_if.s                                :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/10 14:35:36 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/10 14:35:41 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%include "libasm.inc"

section .text
	; global ft_list_remove_if

;void ft_list_remove_if(t_list **begin_list, void *data_ref, \
;	int (*cmp)(), void (*free_fct)(void *));
ft_list_remove_if:
	xor r10, r10 ;		rbx == previous == NULL
	mov rax, [rdi];		rax == actual (and first elem now)
	.loop:

		jmp .loop

.end:
	ret
