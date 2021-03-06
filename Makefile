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
#    Updated: 2020/08/15 01:24:09 by juligonz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


UNAME := $(shell uname)


NAME       = libasm.a
DEBUG_EXEC = debug

SRC_DIR = srcs
OBJ_DIR = obj

SRC = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_strdup.s ft_write.s ft_read.s
SRC+= ft_atoi_base.s
SRC+= ft_list_push_front.s ft_list_size.s ft_list_remove_if.s ft_list_sort.s

SRC+= ft_isspace.s ft_create_elem.s ft_strchr.s

OBJ     = $(addprefix  $(OBJ_DIR)/,$(SRC:%.s=%.o))
vpath %.s $(SRC_DIR)

CC      = gcc
CFLAGS  = -Wall -Wextra -Werror -g -fsanitize=address -fsanitize=undefined -fstack-protector  

AS      = nasm
SFLAGS	= 

#OS specific
ifeq ($(UNAME), Darwin)
	# mac
	SFLAGS += -f macho64 -d MACHO64
else
	#Linus and others...
	SFLAGS += -f elf64 -d ELF64
endif

all: $(NAME)

$(OBJ_DIR)/%.o: %.s
	@mkdir -p $(OBJ_DIR)
	@$(AS) $(SFLAGS) $< -o $@

$(NAME): $(OBJ)
	@ar rcs $(NAME) $^
	@printf "$(_GREEN)Compiled : $(_MAGENTA)$(NAME)$(_R)\n"
	@printf "\nDo $(_CYAN)$(_BOLD)make show$(_R) to debug the Makefile\n"
	@printf "Do $(_RED)$(_BOLD)make debug$(_R) to run tests with lldb\n"
	@printf "Do $(_YELLOW)$(_BOLD)make valgrind$(_R) to run valgrind $(_MAGENTA)(May have falses positives under OSX)$(_R)\n"
	@printf "Do $(_GREEN)$(_BLINK)$(_BOLD)make run$(_R)   to run tests\n\n"

run: $(NAME)
	@$(CC) $(CFLAGS) main.c -L. -l asm -o debug
	@./$(DEBUG_EXEC)

valgrind: $(NAME)
	@$(CC) $(CFLAGS) main.c -L. -l asm -o debug
	@valgrind --leak-check=full --show-leak-kinds=all --show-reachable=yes --trace-children=yes --track-origins=yes --log-file=output_valgrind ./$(DEBUG_EXEC)
	@printf "$(_BOLD)$(_RED)################################################################$(_R)\n"
	@printf "$(_BOLD)$(_RED)##########################  $(_GREEN)Valgrind$(_RED)  ##########################$(_R)\n"
	@printf "$(_BOLD)$(_RED)################################################################$(_R)\n\n"
	@cat output_valgrind

debug:	SFLAGS += -g -w+all -F dwarf
debug: $(NAME)
	@$(CC) $(CFLAGS) main.c -L. -l asm -o debug
	@lldb ./debug

clean:
	@rm -rf $(OBJ_DIR) output_valgrind
	@printf "$(_RED)Removed :$(_MAGENTA) $(OBJ_DIR)/$(_MAGENTA)\n"

fclean: clean
	@rm -fr $(NAME) $(DEBUG_EXEC) debug.dSYM/
	@printf "$(_RED)Removed : $(_MAGENTA)$(NAME), $(DEBUG_EXEC), debug.dSYM/$(_R)\n"

re_echo:
	@printf "$(_CYAN)Redoing $(_BOLD)ALLL $(_R)$(_CYAN)$(_DIM)the things$(_R)$(_BOLD)$(_YELLOW)...$(_R)\n\n"

re: re_echo fclean all

show:
	@printf "$(_MAGENTA)UNAME  :$(_GREEN)  $(UNAME)$(_END)\n"
	@printf "$(_MAGENTA)ARCH   :$(_GREEN)  $(shell uname -p)$(_END)\n\n"
	@printf "$(_CYAN)CC     :$(_RED)  $(CC)$(_END)\n"
	@printf "$(_CYAN)CFLAGS :$(_RED)  $(CFLAGS)$(_END)\n\n"
	@printf "$(_CYAN)AS     :$(_RED)  $(AS)$(_END)\n"
	@printf "$(_CYAN)SFLAGS :$(_RED)  $(SFLAGS)$(_END)\n\n"
	@printf "$(_CYAN)SRC    :$(_RED)  $(SRC)$(_END)\n"
	@printf "$(_CYAN)OBJ    :$(_RED)  $(OBJ)$(_END)\n"

.PHONY: clean fclean re all bonus debug re_echo show
