# https://misc.flogisoft.com/bash/tip_colors_and_formatting
_BOLD      =\e[1m
_DIM       =\e[2m
_UNDERLINE =\e[4m
_BLINK     =\e[5m
_REVERSE   =\e[7m
_HIDDEN    =\e[8m

# RESET list
_R          =\e[0m
_RBOLD      =\e[21m
_RDIM       =\e[22m
_RUNDERLINE =\e[24m
_RBLINK     =\e[25m
_RREVERSE   =\e[27m
_RHIDDEN    =\e[28m

# Colors
_RED      =\e[91m
_GREEN    =\e[92m
_YELLOW   =\e[93m
_BLUE     =\e[94m
_MAGENTA  =\e[35m
_CYAN     =\e[96m
_WHITE    =\e[97m

# Inverted, i.e. colored backgrounds
_IRED     =\e[101m
_IGREEN   =\e[102m
_IYELLOW  =\e[103m
_IBLUE    =\e[104m
_IMAGENTA =\e[45m
_ICYAN    =\e[106m
_IWHITE   =\e[107m

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: juligonz <juligonz@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/18 10:11:39 by juligonz          #+#    #+#              #
#    Updated: 2020/05/26 13:33:23 by juligonz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME       = libasm.a
DEBUG_EXEC = debug

OBJ_DIR = obj

SRC = ft_strlen.s ft_strcpy.s
SRC+= ft_strcmp.s

OBJ     = $(addprefix  $(OBJ_DIR)/,$(SRC:%.s=%.o))

CC      = clang
CFLAGS  = -Wall -Wextra -Werror -g # -fsanitize=address  -fsanitize=undefined -fstack-protector  

AS      = nasm
SFLAGS = -f elf64


all: $(NAME)

$(OBJ_DIR)/%.o: %.s
	@mkdir -p $(OBJ_DIR)
	@$(AS) $(SFLAGS) $< -o $@

$(NAME): $(OBJ)
	@ar rcs $(NAME) $^
	@echo "$(_GREEN)Compiled : $(_MAGENTA)$(NAME)$(_R)"
	@echo "\nDo $(_YELLOW)$(_BOLD)make debug$(_R) to run tests with lldb"
	@echo "Do $(_YELLOW)$(_BLINK)$(_BOLD)make run$(_R)   to run tests"

run: $(NAME)
	@$(CC) $(CFLAGS) main.c -L. -l asm -o debug
	@echo "$(_BOLD)$(_RED)########################## $(_GREEN)Let's go !$(_RED) ##########################$(_R)"
	@./debug

debug: $(NAME)
	@$(CC) $(CFLAGS) main.c -L. -l asm -o debug
	@echo "$(_BOLD)$(_RED)########################## $(_GREEN)Let's go !$(_RED) ##########################$(_R)"
	@lldb ./debug

clean:
	@rm -rf $(OBJ_DIR)
	@echo "$(_RED)Removed :$(_MAGENTA) $(OBJ_DIR)/$(_MAGENTA)"

fclean: clean
	@rm -f $(NAME) $(DEBUG_EXEC)
	@echo "$(_RED)Removed : $(_MAGENTA)$(NAME), $(DEBUG_EXEC)$(_R)"

re_echo:
	@echo "$(_CYAN)Redoing $(_BOLD)ALLL $(_R)$(_CYAN)$(_DIM)the things $(_R)$(_BLINK)$(_BOLD)$(_YELLOW)...$(_R)\n"

re: re_echo fclean all

show:
	@echo "$(_CYAN)CC     :$(_RED)  $(CC)$(_END)"
	@echo "$(_CYAN)CFLAGS :$(_RED)  $(CFLAGS)$(_END)\n"
	@echo "$(_CYAN)AS     :$(_RED)  $(AS)$(_END)"
	@echo "$(_CYAN)SFLAGS :$(_RED)  $(SFLAGS)$(_END)\n"
	@echo "$(_CYAN)SRC    :$(_RED)  $(SRC)$(_END)"
	@echo "$(_CYAN)OBJ    :$(_RED)  $(OBJ)$(_END)"


.PHONY: clean fclean re all bonus debug re_echo show
