GREP_TARGET = s21_grep
GREP_PATH = s21_grep.c
CC = gcc
FLAGS = -Wall -Werror -Wextra -std=c11


s21_grep :
	$(CC) $(FLAGS) $(GREP_PATH) -o $(GREP_TARGET)

rebuild : clean
	$(CC) $(FLAGS) $(GREP_PATH) -o $(GREP_TARGET)

clang : 
	cp ../../materials/linters/.clang-format .
	clang-format -style=file *.c -output-replacements-xml > clang_errors_grep.xml

clean :
	rm -rf $(GREP_TARGET)

test :
	bash grep_test.sh
		
