/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/05/22 13:23:35 by juligonz          #+#    #+#             */
/*   Updated: 2020/05/22 18:46:35 by juligonz         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include <stdio.h>
#include <string.h>

// https://misc.flogisoft.com/bash/tip_colors_and_formatting
#define _BOLD      "\e[1m"
#define _DIM       "\e[2m"
#define _UNDERLINE "\e[4m"
#define _BLINK     "\e[5m"
#define _REVERSE   "\e[7m"
#define _HIDDEN    "\e[8m"

// RESET list
#define _R          "\e[0m"
#define _RBOLD      "\e[21m"
#define _RDIM       "\e[22m"
#define _RUNDERLINE "\e[24m"
#define _RBLINK     "\e[25m"
#define _RREVERSE   "\e[27m"
#define _RHIDDEN    "\e[28m"

// Colors
#define _RED      "\e[91m"
#define _GREEN    "\e[92m"
#define _YELLOW   "\e[93m"
#define _BLUE     "\e[94m"
#define _MAGENTA  "\e[35m"
#define _CYAN     "\e[96m"
#define _WHITE    "\e[97m"

void print_title(char *s)
{
	static int n = 1;
	printf("\n%s%s%d/ %s :%s\n\n", _BLUE, _BOLD, n++, s, _R);
}

int main()
{
	print_title("ft_strlen"); printf("%s", _GREEN);
	
	printf("%zu == %zu\n", strlen(""), ft_strlen(""));	
	printf("%zu == %zu\n", strlen("34"), ft_strlen("34"));	
	printf("%zu == %zu\n", strlen("123"), ft_strlen("123"));	

	print_title("ft_strcpy"); printf("%s", _GREEN);

	print_title("ft_strcmp"); printf("%s", _GREEN);

	print_title("ft_strdup"); printf("%s", _GREEN);

	print_title("ft_write"); printf("%s", _GREEN);

	print_title("ft_read"); printf("%s", _GREEN);


	//Bonus Part
	printf("%s%s######################## %sBonus functions %s########################\n", _BOLD, _GREEN, _RED , _GREEN);
	
	print_title("ft_atoi_base"); printf("%s", _GREEN);
	
	print_title("ft_list_push_front"); printf("%s", _GREEN);
	
	print_title("ft_list_size"); printf("%s", _GREEN);
	
	print_title("ft_list_sort"); printf("%s", _GREEN);
	
	print_title("ft_list_remove_if"); printf("%s", _GREEN);

	return (0);
}
