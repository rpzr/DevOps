#ifndef S21_GREP_H
#define S21_GREP_H

#define _GNU_SOURCE
#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define REG_MATCH 0
#define BUF_SIZE 128

typedef struct grep_flags {
  int e;
  int i;
  int v;
  int c;
  int l;
  int n;
  int h;
  int s;
  int f;
  int o;
  char *pattern;
  size_t length;
} grep_flags;

void regex_process(grep_flags options, int argc, char *argv[]);
int parse_flags(grep_flags *options, char *argv[], int argc);
void print_result(int argc, FILE *fp, grep_flags options, char *path,
                  regex_t *preg);
void file_process(grep_flags options, int argc, char *path, regex_t *preg);
void output_line(char *path, char *line, int n, grep_flags options,
                 int nonflag_args, int lines, int cflag);
void grep_error_message(grep_flags options);
int files_count(int argc);
void add_eflag_expression(grep_flags *options, char *arg);
void parse_expression_from_file(grep_flags *options, char *path);
void print_oflag(regex_t *preg, char *line);

#endif