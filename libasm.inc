;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    libasm.inc                                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: juligonz <marvin@42.fr>                    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2020/08/07 14:07:37 by juligonz          #+#    #+#              ;
;    Updated: 2020/08/07 14:07:43 by juligonz         ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

%pragma macho gprefix _

DEFAULT REL

%ifdef MACHO64

	%define SYS_READ  0x2000003
	%define SYS_WRITE 0x2000004
	
	%define SYM_ERRNO __error
%else
	%define SYS_READ 0
	%define SYS_WRITE 1

	%define SYM_ERRNO __errno_location
%endif
