CAT_TARGET = s21_cat
CAT_PATH = s21_cat.c
CC = gcc
FLAGS = -Wall -Werror -Wextra -std=c11

all : s21_cat

s21_cat : 
	$(CC) $(FLAGS) $(CAT_PATH) -o $(CAT_TARGET)

rebuild : clean
	$(CC) $(FLAGS) $(CAT_PATH) -o $(CAT_TARGET)

clean :
	rm -rf $(CAT_TARGET)

clang : 
	cp ../../materials/linters/.clang-format .
	clang-format -style=file *.c -output-replacements-xml > clang_errors_cat.xml

test : 
	bash cat_test.sh
