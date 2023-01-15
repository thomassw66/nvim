#include <fcntl.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>

#include <errno.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>

#include "unix_helpers.h"


int main(int argc, char *argv[]) {

  void *addr;
  int fd;
  struct stat sb;

  if (argc != 2 || strcmp(argv[1], "--help") == 0) {
    fprintf(stderr, "usage: %s file\n", argv[0]);
    exit(1);
  }

  fd = open(argv[1], O_RDONLY);
  if (fd == -1) {
    err_exit("[failed] open");
  }

  int fstat_result = fstat(fd, &sb);
  if (fstat_result == -1) {
    err_exit("[failed] fstat");
  }

  addr = mmap(NULL, (size_t)sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  if (addr == MAP_FAILED)
    err_exit("[failed] mmap");

  int write_result = write(STDOUT_FILENO, addr, (size_t)sb.st_size);
  if (write_result != sb.st_size) {
    fatal("[failed] partial write");
  }

  exit(EXIT_SUCCESS);
}
