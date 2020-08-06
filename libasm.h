/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/05/22 13:10:24 by juligonz          #+#    #+#             */
/*   Updated: 2020/08/06 02:03:09 by juligonz         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# include <unistd.h>

size_t		ft_strlen(const char *s);
char		*ft_strcpy(char *dest, const char *src);
int			ft_strcmp(const char *s1, const char *s2);
char		*ft_strdup(const char *s);

ssize_t		ft_write(int fd, const void *buf, size_t count);
ssize_t		ft_read(int fd, void *buf, size_t count);

int			ft_atoi_base(char *str, char *base);

// ft_list_push_front (Comme celui de piscine)
// ft_list_size (Comme celui de piscine)
// ft_list_sort (Comme celui de piscine)
// ft_list_remove_if (Comme celui de piscine)

int			ft_isspace(int c);

#endif
