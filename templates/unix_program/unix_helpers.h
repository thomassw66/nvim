
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
#include <cstdarg>

#define MAX_ENAME 133

extern const char *ename[MAX_ENAME];

__attribute__((__noreturn__)) extern void terminate(bool useExit3);


/* Diagnose 'errno' error by:

      * outputting a string containing the error name (if available
        in 'ename' array) corresponding to the value in 'err', along
        with the corresponding error message from strerror(), and

      * outputting the caller-supplied error message specified in
        'format' and 'ap'. */

extern void outputError(bool useErr, int err, bool flushStdout,
                        const char *format, va_list ap);


extern void fatal(const char *format, ...);


/* Display error message including 'errno' diagnostic, and
   terminate the process by calling _exit().

   The relationship between this function and errExit() is analogous
   to that between _exit(2) and exit(3): unlike errExit(), this
   function does not flush stdout and calls _exit(2) to terminate the
   process (rather than exit(3), which would cause exit handlers to be
   invoked).

   These differences make this function especially useful in a library
   function that creates a child process that must then terminate
   because of an error: the child must terminate without flushing
   stdio buffers that were partially filled by the caller and without
   invoking exit handlers that were established by the caller. */

extern void err_exit(const char *format, ...);





