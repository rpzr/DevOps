#include "s21_grep.h"

int main(int argc, char *argv[]) {
  grep_flags options = {0};
  int parse_flags_error;
  parse_flags_error = parse_flags(&options, argv, argc);
  if (argc == optind) {
    options.s = 0;
    grep_error_message(options);
    exit(EXIT_FAILURE);
  }
  if (parse_flags_error != 1) {
    regex_process(options, argc, argv);
  }
  free(options.pattern);
  return 0;
}

int parse_flags(grep_flags *options, char *argv[], int argc) {
  int flag;
  int error_value = 0;
  while ((flag = getopt(argc, argv, "e:ivclnhsf:o")) != -1) {
    switch (flag) {
      case 'e':
        options->e = 1;
        add_eflag_expression(options, optarg);
        break;
      case 'i':
        options->i = REG_ICASE;
        break;
      case 'v':
        options->v = 1;
        break;
      case 'c':
        options->c = 1;
        break;
      case 'l':
        options->l = 1;
        break;
      case 'n':
        options->n = 1;
        break;
      case 'h':
        options->h = 1;
        break;
      case 's':
        options->s = 1;
        break;
      case 'f':
        options->f = 1;
        parse_expression_from_file(options, optarg);
        break;
      case 'o':
        options->o = 1;
        break;
      default:
        grep_error_message(*options);
        error_value = 1;
    }
  }
  if (options->length == 0) {
    if (argc != optind) {
      add_eflag_expression(options, argv[optind]);
      optind++;
    }
  }
  return error_value;
}

void regex_process(grep_flags options, int argc, char *argv[]) {
  int regex_compile_error = 0;
  regex_t preg;
  if (regcomp(&preg, options.pattern, REG_EXTENDED | options.i)) {
    if (options.s != 1) {
      fprintf(stderr, "Regex compile error\n");
      regex_compile_error = 1;
    }
  }
  if (regex_compile_error != 1) {
    for (int i = optind; i < argc; i++) {
      file_process(options, argc, argv[i], &preg);
    }
  }
  regfree(&preg);
}
void file_process(grep_flags options, int argc, char *path, regex_t *preg) {
  FILE *fp = fopen(path, "r");
  if (fp == NULL) {
    if (!options.s) {
      fprintf(stderr, "grep: %s: No such file or directory\n", path);
    }
  } else {
    print_result(argc, fp, options, path, preg);
    fclose(fp);
  }
}
void print_result(int argc, FILE *fp, grep_flags options, char *path,
                  regex_t *preg) {
  int nonflag_args = files_count(argc);
  char *line = NULL;
  size_t memory_count = 0;
  int symbol_count = 0;
  int cflag = 0;
  int lflag = 0;
  int lines = 1;
  symbol_count = getline(&line, &memory_count, fp);
  while (symbol_count != -1) {
    int match = regexec(preg, line, 0, NULL, 0);
    if ((match == REG_MATCH && !options.v) ||
        (options.v && match == REG_NOMATCH)) {
      if (options.c) {
        cflag++;
      }
      if (options.l && lflag != 1) {
        printf("%s\n", path);
        lflag = 1;
      }
      output_line(path, line, symbol_count, options, nonflag_args, lines,
                  cflag);
      if (options.o && !options.v && !options.c && !options.l) {
        print_oflag(preg, line);
      }
    }
    lines++;
    symbol_count = getline(&line, &memory_count, fp);
  }
  if (options.c && !options.l) {
    printf("%d\n", cflag);
  }
  free(line);
}

void print_oflag(regex_t *preg, char *line) {
  regmatch_t res;
  size_t bias = 0;
  while (1) {
    int result = regexec(preg, line + bias, 1, &res, 0);
    if (result != 0) {
      break;
    }
    for (int i = res.rm_so; i < res.rm_eo; i++) {
      printf("%c", line[i + bias]);
    }
    printf("\n");
    bias += res.rm_eo;
  }
}

void output_line(char *path, char *line, int n, grep_flags options,
                 int nonflagargs, int lines, int cflag) {
  if (cflag <= 1 && !options.l && !options.h && nonflagargs > 1) {
    printf("%s:", path);
  }
  if (options.n && !options.c && !options.l) {
    printf("%d:", lines);
  }
  if (!options.c && !options.l && !options.o) {
    for (int i = 0; i < n; i++) {
      printf("%c", line[i]);
      if (i + 1 == n && line[i] != '\n') {
        putchar('\n');
      }
    }
  }
}

void add_eflag_expression(grep_flags *options, char *arg) {
  int exp_size = strlen(arg);
  if (options->length == 0) {
    options->pattern = malloc(BUF_SIZE * sizeof(char));
  }
  if (options->length != 0) {
    sprintf(options->pattern + options->length, "|");
    options->length++;
  }
  size_t buffersize = BUF_SIZE;
  while (buffersize < options->length + exp_size) {
    options->pattern = realloc(options->pattern, BUF_SIZE * 2);
    buffersize *= 2;
  }
  size_t bias = sprintf(options->pattern + options->length, "(%s)", arg);
  options->length += bias;
}

void parse_expression_from_file(grep_flags *options, char *path) {
  FILE *fp = fopen(path, "r");
  if (fp == NULL && !options->s) {
    fprintf(stderr, "grep: %s: No such file or directory\n", path);
  } else {
    char *line = NULL;
    size_t memory_count = 0;
    int symbol_count = 0;
    symbol_count = getline(&line, &memory_count, fp);
    while (symbol_count != -1) {
      if (line[symbol_count - 1] == '\n') {
        line[symbol_count - 1] = '\0';
      }
      add_eflag_expression(options, line);
      symbol_count = getline(&line, &memory_count, fp);
    }
    free(line);
    fclose(fp);
  }
}

void grep_error_message(grep_flags options) {
  if (options.s != 1) {
    printf(
        "Usage: grep [OPTION]... PATTERNS [FILE]...\nTry 'grep --help' for "
        "more information.\n");
  }
}

int files_count(int argc) {
  int nonflag_args = 0;
  for (int i = optind; i < argc; i++) {
    nonflag_args++;
  }
  return nonflag_args;
}
