/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/05/22 13:23:35 by juligonz          #+#    #+#             */
/*   Updated: 2020/08/04 20:32:34 by juligonz         ###   ########.fr       */
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

void test_ft_strlen()
{
	print_title("ft_strlen"); printf("%s", _YELLOW);

	printf("%zu == %zu\n", ft_strlen(""), 	strlen(""));
	printf("%zu == %zu\n", ft_strlen("34"), strlen("34"));
	printf("%zu == %zu\n", ft_strlen("123"),strlen("123"));	
}

void test_ft_strcpy()
{
	print_title("ft_strcpy"); printf("%s", _GREEN);

	char s1[10] = "salut";
	char s2[10] = "012345678";

	ft_strcpy(s2, s1);
	printf("\"%s\" == \"%s\"\n", s1, s2);	
	
}

void test_ft_strcmp()
{
	print_title("ft_strcmp"); printf("%s", _GREEN);
	char s1[5] = "abc";
	
	char s2[5] = "abe";
	char s3[5] = "aba";
	char s4[5] = "dab";

	char s6[5] = "a";
	char s7[5] = "z";

	printf("%d == %d\n", ft_strcmp(s1,s1), strcmp(s1,s1));
	
	printf("%d == %d\n", ft_strcmp(s1,s2), strcmp(s1,s2));
	printf("%d == %d\n", ft_strcmp(s1,s3), strcmp(s1,s3));
	printf("%d == %d\n", ft_strcmp(s1,s4), strcmp(s1,s4));
	
	printf("%d == %d\n", ft_strcmp(s6,s6), strcmp(s6,s6));

	printf("%d == %d\n", ft_strcmp(s6,s7), strcmp(s6,s7));

		
}

void test_ft_strdup()
{
	print_title("ft_strdup"); printf("%s", _GREEN);
	
	char *str = NULL;

	printf("\"(null)\" == \"%s\"\n", str);
	str = ft_strdup("abcd");
	printf("\"abcd\" == \"%s\"\n", str);
	
	// free(str);
}

void test_ft_write()
{
	print_title("ft_write"); printf("%s", _GREEN);

}

void test_ft_read()
{
	print_title("ft_read"); printf("%s", _GREEN);

}


int main()
{
	test_ft_strlen();
	test_ft_strcpy();
	test_ft_strcmp();
	test_ft_strdup();
	test_ft_write();
	test_ft_read();

	// //Bonus Part
	// printf("%s%s######################## %sBonus functions %s########################\n", _BOLD, _GREEN, _RED , _GREEN);
	// print_title("ft_atoi_base"); printf("%s", _GREEN);
	// print_title("ft_list_push_front"); printf("%s", _GREEN);
	// print_title("ft_list_size"); printf("%s", _GREEN);
	// print_title("ft_list_sort"); printf("%s", _GREEN);
	// print_title("ft_list_remove_if"); printf("%s", _GREEN);

	return (0);
}
