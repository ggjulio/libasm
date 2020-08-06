/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/05/22 13:23:35 by juligonz          #+#    #+#             */
/*   Updated: 2020/08/06 02:58:11 by juligonz         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <ctype.h>

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

	void *p = ft_strcpy(s2, s1);
	printf("\"%s\" == \"%s\"\n", s1, s2);	
	
	if (p != s2)
		printf("%s", _RED);
	printf("%p == %p\n", p, s2);
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
	if (str == NULL || strcmp(str, "abcd"))
		printf("%s", _RED);
	printf("\"abcd\" == \"%s\"\n", str);
	if (str)
		free(str);
}

void test_ft_write()
{
	char str[10] = "|abcd|";
	print_title("ft_write"); printf("%s", _GREEN);

	printf(" > ");fflush(stdout);
	
	write(1, str, strlen(str));
	printf(" == ");fflush(stdout);
	ft_write(1, str, ft_strlen(str));
	printf("\n");
}

void test_ft_read()
{
	print_title("ft_read"); printf("%s", _GREEN);

	int fd = open("libasm.a",O_RDONLY);
	char str[1000];
	
	int ret = ft_read(fd, &str, 50);

	printf("ret: %d chars\n\"%s\"\n", ret, str);

	close(fd);
}


void test_ft_atoi_base()
{
	print_title("ft_atoi_base"); printf("%s", _GREEN);
	
	int res = ft_atoi_base("a","0123456789abcdef");
	printf("10 == %d", res);
}

void test_ft_isspace()
{
	print_title("ft_isspace"); printf("%s", _GREEN);
	printf(" %d == %d\n", isspace(' '), ft_isspace(' '));
	printf(" %d == %d\n", isspace('\f'), ft_isspace('\f'));
	printf(" %d == %d\n", isspace('\n'), ft_isspace('\n'));
	printf(" %d == %d\n", isspace('\r'), ft_isspace('\r'));
	printf(" %d == %d\n", isspace('\t'), ft_isspace('\t'));
	printf(" %d == %d\n", isspace('\v'), ft_isspace('\v'));
	printf(" %d == %d\n", isspace(0), ft_isspace(0));
	printf(" %d == %d\n", isspace(3), ft_isspace(3));
	printf(" %d == %d\n", isspace('a'), ft_isspace('a'));
	printf(" %d == %d\n", isspace('1'), ft_isspace('1'));
}

int main()
{
	test_ft_strlen();
	test_ft_strcpy();
	test_ft_strcmp();
	test_ft_strdup();
	test_ft_write();
	test_ft_read();

	//Bonus Part
	printf("\n\n%s%s######################## %sBonus functions %s########################\n", _BOLD, _GREEN, _RED , _GREEN);
	
	test_ft_atoi_base();

	// print_title("ft_list_push_front"); printf("%s", _GREEN);
	// print_title("ft_list_size"); printf("%s", _GREEN);
	// print_title("ft_list_sort"); printf("%s", _GREEN);
	// print_title("ft_list_remove_if"); printf("%s", _GREEN);

	// //Optional
	// printf("\n\n%s%s######################## %sAdditional functions %s########################\n", _BOLD, _GREEN, _RED , _GREEN);

	// test_ft_isspace();
	
	return (0);
}
