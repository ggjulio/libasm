/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/05/22 13:23:35 by juligonz          #+#    #+#             */
/*   Updated: 2020/08/15 00:03:03 by juligonz         ###   ########.fr       */
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
void print_equal_size_t(size_t expected, size_t real)
{
	printf("%s   %zu == %zu\n", expected == real ? _GREEN : _RED, expected, real);	
}
void print_equal_ptr(void *expected, void *real)
{
	printf("%s   %p == %p\n", expected == real ? _GREEN : _RED, expected, real);	
}
void print_equal_int(int expected, int real)
{
	printf("%s   %3d   == %3d\n", expected == real ? _GREEN : _RED , expected, real);
}
void print_equal_str(char *expected, char *real)
{
	printf("%s   \"%s\" == \"%s\"\n", strcmp(expected, real) == 0 ? _GREEN : _RED , expected, real);
}

void test_ft_strlen()
{
	print_title("ft_strlen"); printf("%s", _YELLOW);

	print_equal_size_t(strlen(""),    ft_strlen(""));
	print_equal_size_t(strlen("34"),  ft_strlen("34"));
	print_equal_size_t(strlen("123"), ft_strlen("123"));
}

void test_ft_strcpy()
{
	print_title("ft_strcpy"); printf("%s", _GREEN);

	char s1[10] = "salut";
	char s2[10] = "012345678";

	char *ret = ft_strcpy(s2, s1);
	print_equal_str(s1, s2);
	printf("%s   %p == %p\n", ret == s2 ? _GREEN : _RED, s2, ret);
	if (ret != s2)
		printf("\n   %s%sstrcpy should return a pointer to the destination string %s\n", _RED, _BOLD, _R);
}

void test_ft_strcmp()
{
	print_title("ft_strcmp"); printf("%s", _GREEN);

	char s1[5] = "abc";
	char s2[2] = "A";
	char s3[2] = "";
	
	print_equal_int(strcmp(s1, "abc"), ft_strcmp(s1, "abc"));
	print_equal_int(strcmp(s1, "abe"), ft_strcmp(s1, "abe"));
	print_equal_int(strcmp(s1, "aba"), ft_strcmp(s1, "aba"));
	print_equal_int(strcmp(s1, "dab"), ft_strcmp(s1, "dab"));

	print_equal_int(strcmp(s2, "a"), ft_strcmp(s2, "a"));
	print_equal_int(strcmp(s2, "z"), ft_strcmp(s2, "z"));

	print_equal_int(strcmp("", s3), ft_strcmp("", s3));
	print_equal_int(strcmp(s3, ""), ft_strcmp(s3, ""));
	
	print_equal_int(strcmp(s3, "!"), ft_strcmp(s3, "!"));
}

void test_ft_strdup()
{
	print_title("ft_strdup"); printf("%s", _GREEN);
	
	char str[20] = "AHhhhh shit !";
	char *str_expected;
	char *str_real;

	str_expected = strdup(str);
	str_real = ft_strdup(str);
	
	print_equal_str(str_expected, str_real);
	
	free(str_expected);
	free(str_real);
}

void test_ft_write()
{
	char str[10] = "|abcde|";
	int ret_expected;
	int ret_real;

	print_title("ft_write"); printf("%s", _GREEN);

// test 1 valid write
	printf("%s 1 - Valid write :\n\n%s", _BLUE, _YELLOW);
	fflush(stdout);
	ret_expected = write(1, str, strlen(str));
	printf(" == ");fflush(stdout);
	ret_real = ft_write(1, str, strlen(str));
	printf("\n\n%s", ret_real == ret_expected ? _GREEN : _RED);
	printf("   return : %d == %d\n", ret_expected, ret_real);
	printf("%s", errno == 0 ? _GREEN : _RED);
	printf("   errno  : 0 == %d ('%s' == '%s')\n\n%s", errno, strerror(0), strerror(errno), _GREEN);
	
// test 2 Bad fd
	printf("%s 2 - Bad file descriptor :%s\n\n", _BLUE, _GREEN);
	ret_expected = -1;
	ret_real = ft_write(-1, str, ft_strlen(str));
	printf("%s", ret_real == ret_expected ? _GREEN : _RED);
	printf("   return : %d == %d\n", ret_expected, ret_real);
	printf("%s", errno == 9 ? _GREEN : _RED);
	printf("   errno  : 9 == %d ('%s' == '%s')\n%s", errno, strerror(9), strerror(errno), _GREEN);
	errno = 0;
}

void test_ft_read()
{
	int ret_expected;
	int ret_real;
	int fd;
	int len;
	char str_expected[100];
	char str_real[100];

	print_title("ft_read"); printf("%s", _GREEN);

// test valid
	len = 7;	
	printf("%s 1 - read 50 chars :\n\n%s", _BLUE, _GREEN);
	
	fd = open("libasm.a", O_RDONLY);
	ret_expected = ft_read(fd, &str_expected, len);
	close(fd);

	fd = open("libasm.a", O_RDONLY);
	ret_real = ft_read(fd, &str_real, len);
	close(fd);

	print_equal_str(str_expected, str_real);
	printf("%s", ret_real == ret_expected ? _GREEN : _RED);
	printf("   return : %d == %d\n", ret_expected, ret_real);
	printf("%s", errno == 0 ? _GREEN : _RED);
	printf("   errno  : 0 == %d ('%s' == '%s')\n\n%s", errno, strerror(0), strerror(errno), _GREEN);
	
// test BAD FG
	bzero(&str_real, 100);
	printf("%s 2 - error Bad File descriptor  :\n\n%s", _BLUE, _GREEN);
	ret_real = ft_read(-42, &str_real, 50);
	ret_expected = -1;
	printf("%s", ret_real == ret_expected ? _GREEN : _RED);
	printf("   return : %d == %d\n", ret_expected, ret_real);	
	printf("%s", errno == 9 ? _GREEN : _RED);
	printf("   errno  : 9 == %d ('%s' == '%s')\n\n%s", errno, strerror(9), strerror(errno), _GREEN);
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

void test_ft_strchr()
{
	print_title("ft_strchr"); printf("%s", _GREEN);

	char str[10] = "hola";
	print_equal_str(strchr(str, 'o'), ft_strchr(str, 'o'));
	print_equal_ptr(strchr(str, 'p'), ft_strchr(str, 'p'));
	print_equal_str(strchr(str, 'a'), ft_strchr(str, 'a'));
	print_equal_str(strchr(str, 'h'), ft_strchr(str, 'h'));
	print_equal_ptr(strchr(str, 0), ft_strchr(str, 0));
}
void test_ft_atoi_base()
{
	print_title("ft_atoi_base"); printf("%s", _GREEN);

	printf("%s 1 - test empty and NULL strings %s\n", _BLUE, _GREEN);
	
	print_equal_int(0, ft_atoi_base("",""));
	print_equal_int(0, ft_atoi_base("12",""));
	print_equal_int(0, ft_atoi_base("","12"));
	print_equal_int(0, ft_atoi_base(NULL, ""));
	print_equal_int(0, ft_atoi_base("", NULL));
	
	printf("%s 2 - testing various things %s\n", _BLUE, _GREEN);
	
	print_equal_int(  6, ft_atoi_base("\n\t\r\f\v  110", "01"));
	print_equal_int(  0, ft_atoi_base(  "\1  110      ", "01"));
	print_equal_int( 32, ft_atoi_base("  ++--20g4      ", "0123456789abcdef"));
	print_equal_int(-32, ft_atoi_base(" ++---20g4", "0123456789abcdef"));
	print_equal_int(-20, ft_atoi_base(" ---20a4", "0123456789"));
	print_equal_int( 20, ft_atoi_base(" 20a4", "0123456789"));
	print_equal_int( 20, ft_atoi_base("20  4", "0123456789"));
	print_equal_int( 42, ft_atoi_base("52 ", "01234567"));
	print_equal_int( 42, ft_atoi_base("52.44 ", "01234567"));
	print_equal_int( 42, ft_atoi_base("52-44 ", "01234567"));
	print_equal_int( 42, ft_atoi_base("52+44 ", "01234567"));
	print_equal_int( 42, ft_atoi_base("00101010", "01"));	
	print_equal_int( 32, ft_atoi_base(" ----00100000", "01"));
	print_equal_int(-34, ft_atoi_base("-00100010", "01"));
	print_equal_int(  7, ft_atoi_base("11142111", "01"));
	print_equal_int(  0, ft_atoi_base("42111", "01"));

	printf("%s 2 - testing bad base string %s\n", _BLUE, _GREEN);
	
	print_equal_int(0, ft_atoi_base("290","20123456789"));
	print_equal_int(0, ft_atoi_base("425","01222245"));
	print_equal_int(0, ft_atoi_base("8888888","88"));
	print_equal_int(0, ft_atoi_base("8888888","8"));
	print_equal_int(0, ft_atoi_base("42","0123456 789"));
	print_equal_int(0, ft_atoi_base("42","0123456+789"));
	print_equal_int(0, ft_atoi_base("42","0123456-789"));
	print_equal_int(0, ft_atoi_base("42",""));
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
		printf("   %d : %p\n", i, lst);
		printf("       data : \"%s\"\n", lst ? lst->data : "(NULL)");
		printf("       next : \"%p\"\n\n", lst ? lst->next : 0);
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
	print_title("ft_list_push_front");

	printf("%s 1 - show list before push front %s\n", _BLUE, _YELLOW);
	ft_list_push_front(&lst, "old elem");
	print_list(lst);

	printf("%s 1 - show  Updated  list %s\n", _BLUE, _YELLOW);
	ft_list_push_front(&lst, "new elem");
	print_list(lst);

	free_list(lst);
}

void test_ft_list_size()
{
	t_list *lst = NULL;
	print_title("ft_list_size"); printf("%s", _WHITE);

	ft_list_push_front(&lst, "elem 1");
	ft_list_push_front(&lst, "elem 2");
	ft_list_push_front(&lst, "elem 3");
	ft_list_push_front(&lst, "elem 4");

	print_list(lst);

	int expected = 4;
	int real = ft_list_size(lst);

	printf("   %sResult  :", _YELLOW);
	print_equal_int(expected, real);
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
	print_title("ft_list_remove_if");
	
	ft_list_push_front(&lst, "elem 1");
	ft_list_push_front(&lst, "elem 0");
	ft_list_push_front(&lst, "elem 1");
	ft_list_push_front(&lst, "elem 3");
	ft_list_push_front(&lst, "elem 2");
	ft_list_push_front(&lst, "elem 2");
	ft_list_push_front(&lst, "elem 2");
	ft_list_push_front(&lst, "elem 3");
	
	printf("%s 1 - Before remove elements %s\n", _BLUE, _WHITE);
	print_list(lst);
	printf("%s 2 - Remove elem 2 %s\n", _BLUE, _YELLOW);
	ft_list_remove_if(&lst, "elem 2", cmp_remove,  free_fct);
	print_list(lst);
	printf("%s 3 - Remove elem 3 %s\n", _BLUE, _YELLOW);
	ft_list_remove_if(&lst, "elem 3", cmp_remove,  free_fct);
	print_list(lst);
	printf("%s 4 - Remove elem 1 %s\n", _BLUE, _YELLOW);
	ft_list_remove_if(&lst, "elem 1", cmp_remove,  free_fct);
	print_list(lst);
	printf("%s 4 - Remove elem 0 %s\n", _BLUE, _YELLOW);
	ft_list_remove_if(&lst, "elem 0", cmp_remove,  free_fct);
	print_list(lst);

	free_list(lst);
}

int cmp_sort(char *s1, char *s2)
{
	return (ft_strcmp(s1,s2));
}

void			ft_list_sort_c(t_list **begin_list, int (*cmp)())
{
	t_list *previous = NULL;
	t_list *actual = *begin_list;
	
	if (actual == NULL)
		return;
	t_list *next = (*begin_list)->next;
	while (actual->next)
	{
		if (cmp(actual->data, next->data) > 0)
		{
			if (previous != NULL)
				previous->next = actual->next;
			else
				*begin_list = actual->next;	

			actual->next= next->next;
			next->next = actual;

			previous = NULL;
			actual = *begin_list;
			next = actual->next;
			continue;
		}	
		previous = actual;
		actual = actual->next;
		next = actual->next;
	}
}

void test_ft_list_sort()
{
	t_list *lst = NULL;

	print_title("ft_list_sort");
	ft_list_push_front(&lst, "elem 5");
	ft_list_push_front(&lst, "elem 7");
	ft_list_push_front(&lst, "ah !");
	ft_list_push_front(&lst, "elem3");
	ft_list_push_front(&lst, "elem 1");
	ft_list_push_front(&lst, "ahh !");
	ft_list_push_front(&lst, "elem 7");
	ft_list_push_front(&lst, "elem 2");
	ft_list_push_front(&lst, "elem 4");
	ft_list_push_front(&lst, "elem 5");
	ft_list_push_front(&lst, "elem 7");


	printf("%s 1 - Before sort %s\n", _BLUE, _WHITE);
	print_list(lst);
	ft_list_sort(&lst, cmp_sort);
	printf("%s 2 - After sort %s\n", _BLUE, _YELLOW);
	print_list(lst);

	free_list(lst);
}

int main()
{
	test_ft_strlen();
	test_ft_strcpy();
	test_ft_strcmp();
	test_ft_write();
	test_ft_read();
	test_ft_strdup();

	//Bonus Part
	printf("\n\n%s%s######################## %sBonus functions %s########################\n", _BOLD, _GREEN, _RED , _GREEN);
	
	test_ft_list_push_front();
	test_ft_list_size();
	test_ft_list_remove_if();
	test_ft_list_sort();

	test_ft_atoi_base();

	// printf("\n\n%s%s######################## %sAdditional functions %s########################\n", _BOLD, _GREEN, _RED , _GREEN);

	// test_ft_isspace();
	// test_ft_create_elem();
	test_ft_strchr();

	// system("leaks debug");
	return (0);
}
