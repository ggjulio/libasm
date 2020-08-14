;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strchr.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/14 22:53:28 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/14 22:53:30 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%include "libasm.inc"

section .text
	global ft_strchr

ft_strchr:
	cmp rsi, byte 0
	jz chr_terminating_null
	.loop:
		cmp byte [rdi], sil
		je end
		cmp byte [rdi], 0
		jz return_null
		add rdi, 1
	jmp .loop
chr_terminating_null:
	.loop:
		cmp byte [rdi], 0
		je end
		add rdi, 1
	jmp .loop

end:
	mov rax, rdi
	ret
return_null:
	mov rax, 0
	ret

