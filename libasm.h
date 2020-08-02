/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/05/22 13:10:24 by juligonz          #+#    #+#             */
/*   Updated: 2020/08/02 15:54:38 by juligonz         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# include <unistd.h>

size_t		ft_strlen(const char *s) asm("_ft_strlen");
char		*ft_strcpy(char *dest, const char *src) asm("_ft_strcpy");
int			ft_strcmp(const char *s1, const char *s2) asm("_ft_strcmp");
char		*ft_strdup(const char *s) asm("_ft_strdup");

ssize_t		ft_write(int fd, const void *buf, size_t count) asm("_ft_write");
ssize_t		ft_read(int fd, void *buf, size_t count) asm("_ft_read");

// ft_atoi_base (Comme celui de piscine)
// ft_list_push_front (Comme celui de piscine)
// ft_list_size (Comme celui de piscine)
// ft_list_sort (Comme celui de piscine)
// ft_list_remove_if (Comme celui de piscine)

#endif
