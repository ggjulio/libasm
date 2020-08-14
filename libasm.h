/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/05/22 13:10:24 by juligonz          #+#    #+#             */
/*   Updated: 2020/08/14 22:59:37 by juligonz         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# include <unistd.h>

typedef struct	s_list
{
	void			*data;
	struct s_list	*next;
}				t_list;

size_t			ft_strlen(const char *s) __attribute__((nonnull(1)));
char			*ft_strcpy(
		char *dest, const char *src) __attribute__((nonnull));
int				ft_strcmp(
		const char *s1, const char *s2) __attribute__((nonnull));
char			*ft_strdup(const char *s) __attribute__((nonnull));
ssize_t			ft_write(int fd, const void *buf, size_t count);
ssize_t			ft_read(int fd, void *buf, size_t count);

int				ft_atoi_base(char *str, char *base);
void			ft_list_push_front(t_list **begin_list, void *data);
int				ft_list_size(t_list *begin_list);
void			ft_list_sort(t_list **begin_list, int (*cmp)());
void			ft_list_remove_if(t_list **begin_list, void *data_ref, \
					int (*cmp)(), void (*free_fct)(void *));

int				ft_isspace(int c);
t_list			*ft_create_elem(void *data);
char			*ft_strchr(const char *s, int c);

#endif
