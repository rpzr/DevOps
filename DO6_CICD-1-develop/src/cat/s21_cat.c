#include "s21_cat.h"

int main(int argc, char *argv[]) {
  cat_flags flags = {0};
  if (parse_flags(&flags, argv, argc) != 1) {
    file_process(argc, argv, flags);
  }
  return 0;
}

int parse_flags(cat_flags *flags, char *argv[], int argc) {
  int error_value = 0;
  struct option long_opt[] = {
      {"number-nonblank", 0, 0, 'b'},
      {"number", 0, 0, 'n'},
      {"squeeze-blank", 0, 0, 's'},
      {NULL, 0, 0, 0},
  };
  int flag;
  while ((flag = getopt_long(argc, argv, "bnsveEtT", long_opt, NULL)) != -1) {
    switch (flag) {
      case 'b':
        flags->b = 1;
        break;
      case 'n':
        flags->n = 1;
        break;
      case 's':
        flags->s = 1;
        break;
      case 'v':
        flags->v = 1;
        break;
      case 'e':
        flags->e = 1;
        flags->v = 1;
        break;
      case 'E':
        flags->e = 1;
        break;
      case 't':
        flags->t = 1;
        flags->v = 1;
        break;
      case 'T':
        flags->t = 1;
        break;
      default:
        fprintf(stderr, "Try 'cat --help' for more information.\n");
        error_value = 1;
    }
  }
  if (flags->b == 1) {
    flags->n = 0;
  }
  return error_value;
}

void file_process(int argc, char *argv[], cat_flags flags) {
  FILE *fp = NULL;
  while (optind < argc) {
    fp = fopen(argv[optind], "r");
    if (fp == NULL) {
      printf("cat: %s: No such file or directory\n", argv[optind++]);
      continue;
    }
    optind++;
    print_result(fp, flags);
  }
  if (fp != NULL) {
    fclose(fp);
  }
}
void print_result(FILE *file, cat_flags flags) {
  static int prev = '\n';
  static int str_count = 0;
  static int empty_str = 0;
  int stop_flag = 0;
  while (!stop_flag) {
    int ch;
    ch = fgetc(file);
    if (ch == EOF) {
      stop_flag = 1;
    }
    if (!stop_flag) {
      if (flags.s) {
        if (print_s(ch, prev, &empty_str)) {
          continue;
        }
      }
      if ((flags.b || flags.n)) {
        print_bn(prev, ch, &str_count, flags);
      }
      if (flags.t) {
        if (print_t(ch)) {
          continue;
        }
      }
      if (flags.v) {
        ch = print_v(ch);
        if (ch == 255) {
          continue;
        }
      }
      if (flags.e) {
        print_e(ch);
      }
      printf("%c", ch);
      prev = ch;
    }
  }
}

void print_bn(int prev, int curr, int *str_count, cat_flags flags) {
  if ((flags.b && prev == '\n' && curr != '\n') || (flags.n && prev == '\n')) {
    printf("%6d\t", ++(*str_count));
  }
}

void print_e(int curr) {
  if (curr == '\n') {
    putchar('$');
  }
}

int print_v(int curr) {
  if (curr == '\n' || curr == '\t') {
    return curr;
  }
  if (curr <= 31) {
    putchar('^');
    curr += 64;
  } else if (curr == 127) {
    putchar('^');
    curr -= 64;
  } else if (curr >= 128 && curr <= 159) {
    printf("M-^");
    curr -= 64;
  } else if (curr >= 160 && curr < 255) {
    printf("M-");
    curr -= 128;
  } else if (curr == 255) {
    printf("M-^?");
  }
  return curr;
}

int print_t(int curr) {
  int tflag = 0;
  if (curr == '\t') {
    putchar('^');
    putchar('I');
    tflag = 1;
  } else
    tflag = 0;
  return tflag;
}

int print_s(int curr, int prev, int *empty_str) {
  int sflag = 0;
  if (curr == '\n' && prev == '\n') {
    if (*empty_str == 1) {
      sflag = 1;
    }
    *empty_str = 1;
  } else {
    *empty_str = 0;
  }
  return sflag;
}
