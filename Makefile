# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/18 10:11:39 by juligonz          #+#    #+#              #
#    Updated: 2020/05/22 13:26:14 by juligonz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME       = libasm.a
DEBUG_EXEC = debug

SRC_DIR = srcs
INC_DIR = includes
OBJ_DIR = obj

SRC = ft_strlen.s

OBJ     = $(addprefix  $(OBJ_DIR)/,$(SRC:%.s=%.o))

CC      = clang
CFLAGS  = -Wall -Wextra -Werror -g # -fsanitize=address  -fsanitize=undefined -fstack-protector  

AS      = nasm
ASFLAGS = -f elf64


all: $(NAME)

$(OBJ_DIR)/%.o: %.s
	mkdir -p $(OBJ_DIR)
	$(AS) $(ASFLAGS) $< -o $@

$(NAME): $(OBJ)
	@echo "Compiling $(NAME)  ..."
	ar rcs $(NAME) $^
	$(info Compiled $(NAME))

debug: $(NAME)
	$(CC)  

clean:
	rm -rf $(OBJ_DIR)
	@echo ".o removed !"

fclean: clean
	rm -f $(NAME) $(DEBUG_EXEC)
	@echo "$(NAME) and $(DEBUG_EXEC) deleted"

re: fclean all


.PHONY: clean fclean re all bonus debug
