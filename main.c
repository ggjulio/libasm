/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/05/22 13:23:35 by juligonz          #+#    #+#             */
/*   Updated: 2020/08/12 15:49:18 by juligonz         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <ctype.h>
#include <errno.h>

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
	int ret_expected;
	int ret_real;

	print_title("ft_write"); printf("%s", _GREEN);

// test 1 valid write
	printf("%s 1 - valid write :%s\n\n", _BLUE, _GREEN);
	
	ret_expected = write(1, str, strlen(str));
	printf(" == ");fflush(stdout);
	ret_real = ft_write(1, str, ft_strlen(str));
	if (ret_real != ret_expected)
		printf("%s", _RED);
	printf("\n ret : %d == %d\n", ret_expected, ret_real);
	printf("%sDescription for error '%d' : %s\n\n%s", _MAGENTA, errno, strerror(errno), _GREEN);
	
// test 2 Bad fd
	printf("%s 2 - Bad file descriptor :%s\n\n", _BLUE, _GREEN);
	ret_real = ft_write(-1, str, ft_strlen(str));
	printf("\n ret : -1 == %d\n", ret_real);
	printf("%sDescription for error '%d' : %s\n\n%s", _MAGENTA, errno, strerror(errno), _GREEN);
	errno = 0;

}

void test_ft_read()
{
	int ret;
	int fd;
	char str[100];

	print_title("ft_read"); printf("%s", _GREEN);

	// test valid	
	printf("%s 1 - read 50 chars :\n\n%s", _BLUE, _GREEN);
	fd = open("libasm.a", O_RDONLY);
	ret = ft_read(fd, &str, 50);
	printf("ret: %d\n\"%s\"\n\n", ret, str);
	printf("%sDescription for error '%d' : %s\n\n%s", _MAGENTA, errno, strerror(errno), _GREEN);
	close(fd);

	// test BAD FG
	bzero(&str, 100);
	printf("%s 2 - error Bad File descriptor  :\n\n%s", _BLUE, _GREEN);
	ret = ft_read(6, &str, 50);
	printf("ret -1: %d\n\"\" == \"%s\"\n", ret, str);
	printf("%sDescription for error '%d' : %s\n\n%s", _MAGENTA, errno, strerror(errno), _GREEN);
	errno = 0;

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

void test_ft_atoi_base()
{
	int ret;
	print_title("ft_atoi_base"); printf("%s", _GREEN);
	
	// ret = ft_atoi_base("","0123456789abcdef");
	// printf("-1 == %d\n", ret);

	// ret = ft_atoi_base("a","");
	// printf("-1 == %d\n", ret);

	ret = ft_atoi_base("a","0123456789abcdef");
	printf("10 == %d\n", ret);
}

void test_ft_create_elem()
{
	print_title("ft_create_elem"); printf("%s", _GREEN);
	t_list	*elem = ft_create_elem("test");
	printf("elem (%p) :\n", elem);
	printf("  data : \"%s\"\n", elem ? elem->data : "(NULL), not my fault ! malloc failed !");
	printf("  next : \"%p\"\n", elem ? elem->next : 0);
	if (elem)
		free(elem);
}
void print_list(t_list *lst)
{
	int i = 1;
	if (lst == NULL)
		printf("	Empty list !\n");
	while (lst)
	{
		printf(" %d : %p\n", i, lst);
		printf("     data : \"%s\"\n", lst ? lst->data : "(NULL)");
		printf("     next : \"%p\"\n\n", lst ? lst->next : 0);
		i++;
		lst = lst->next;
	}
}
void free_list(t_list *to_free)
{
	t_list *tmp = NULL; 
	
	while(to_free)
	{
		tmp = to_free->next ? to_free->next : NULL;
		free(to_free);
		to_free = tmp;
	}
}

void test_ft_list_push_front()
{
	t_list *lst = NULL;
	print_title("ft_list_push_front"); printf("%s", _GREEN);

	printf("%s 1 - show list before push front %s\n", _BLUE, _GREEN);
	ft_list_push_front(&lst, "old elem");
	print_list(lst);

	printf("%s 1 - show  Updated  list %s\n", _BLUE, _GREEN);
	ft_list_push_front(&lst, "new elem");
	print_list(lst);

	free_list(lst);
}

void test_ft_list_size()
{
	t_list *lst = NULL;
	print_title("ft_list_size"); printf("%s", _GREEN);

	ft_list_push_front(&lst, "elem 1");
	ft_list_push_front(&lst, "elem 2");
	ft_list_push_front(&lst, "elem 3");
	ft_list_push_front(&lst, "elem 4");


	int expected = 4;
	int real = ft_list_size(lst);
	if (real == expected)
		printf("%d == %d\n", expected, real);
	else
		printf("%s%d != %d\n", _RED, expected, real);
	free_list(lst);
}

int	cmp_remove(char *s1, char *s2)
{
	int i = strcmp(s1,s2);
	return (i);
}
void free_fct(void *nothing)
{
	(void)nothing;
	return;
}

void test_ft_list_remove_if()
{
	t_list *lst = NULL;
	print_title("ft_list_remove_if"); printf("%s", _GREEN);
	
	ft_list_push_front(&lst, "elem 1");
	ft_list_push_front(&lst, "elem 0");
	ft_list_push_front(&lst, "elem 1");
	ft_list_push_front(&lst, "elem 3");
	ft_list_push_front(&lst, "elem 2");
	ft_list_push_front(&lst, "elem 2");
	ft_list_push_front(&lst, "elem 2");
	ft_list_push_front(&lst, "elem 3");
	
	printf("%s 1 - Before remove elements %s\n", _BLUE, _GREEN);
	print_list(lst);
	printf("%s 2 - Remove elem 2 %s\n", _BLUE, _GREEN);
	ft_list_remove_if(&lst, "elem 2", cmp_remove,  free_fct);
	print_list(lst);
	printf("%s 3 - Remove elem 3 %s\n", _BLUE, _GREEN);
	ft_list_remove_if(&lst, "elem 3", cmp_remove,  free_fct);
	print_list(lst);
	printf("%s 4 - Remove elem 1 %s\n", _BLUE, _GREEN);
	ft_list_remove_if(&lst, "elem 1", cmp_remove,  free_fct);
	print_list(lst);
	printf("%s 4 - Remove elem 0 %s\n", _BLUE, _GREEN);
	ft_list_remove_if(&lst, "elem 0", cmp_remove,  free_fct);
	print_list(lst);
	

	free_list(lst);

}


void test_ft_list_sort()
{
	
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
	// printf("\n\n%s%s######################## %sBonus functions %s########################\n", _BOLD, _GREEN, _RED , _GREEN);
	
	test_ft_list_push_front();
	test_ft_list_size();
	test_ft_list_remove_if();
	// print_title("ft_list_sort"); printf("%s", _GREEN);
	// test_ft_atoi_base();

	// //Optional
	// printf("\n\n%s%s######################## %sAdditional functions %s########################\n", _BOLD, _GREEN, _RED , _GREEN);

	// test_ft_isspace();
	// test_ft_create_elem();

	return (0);
}
