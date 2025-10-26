#ifndef S21_CAT_H
#define S21_CAT_H

#include <getopt.h>
#include <stdio.h>

typedef struct cat_flags {
  int b;
  int e;
  int n;
  int s;
  int t;
  int v;
} cat_flags;

void file_process(int argc, char *argv[], cat_flags flags);
int parse_flags(cat_flags *flags, char *argv[], int argc);
void print_result(FILE *file, cat_flags flags);
void print_e(int curr);
int print_s(int curr, int prev, int *empty_str);
int print_v(int curr);
int print_t(int curr);
void print_bn(int prev, int curr, int *str_count, cat_flags flags);

#endif