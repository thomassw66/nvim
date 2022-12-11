#include "unix_helpers.h"

const char *ename[] = {"",
                        "EPERM",
                        "ENOENT",
                        "ESRCH",
                        "EINTR",
                        "EIO",
                        "ENXIO",
                        "E2BIG",
                        "ENOEXEC",
                        "EBADF",
                        "ECHILD",
                        "EAGAIN/EWOULDBLOCK",
                        "ENOMEM",
                        "EACCES",
                        "EFAULT",
                        "ENOTBLK",
                        "EBUSY",
                        "EEXIST",
                        "EXDEV",
                        "ENODEV",
                        "ENOTDIR",
                        "EISDIR",
                        "EINVAL",
                        "ENFILE",
                        "EMFILE",
                        "ENOTTY",
                        "ETXTBSY",
                        "EFBIG",
                        "ENOSPC",
                        "ESPIPE",
                        "EROFS",
                        "EMLINK",
                        "EPIPE",
                        "EDOM",
                        "ERANGE",
                        "EDEADLK/EDEADLOCK",
                        "ENAMETOOLONG",
                        "ENOLCK",
                        "ENOSYS",
                        "ENOTEMPTY",
                        "ELOOP",
                        "",
                        "ENOMSG",
                        "EIDRM",
                        "ECHRNG",
                        "EL2NSYNC",
                        "EL3HLT",
                        "EL3RST",
                        "ELNRNG",
                        "EUNATCH",
                        "ENOCSI",
                        "EL2HLT",
                        "EBADE",
                        "EBADR",
                        "EXFULL",
                        "ENOANO",
                        "EBADRQC",
                        "EBADSLT",
                        "EBFONT",
                        "ENOSTR",
                        "ENODATA",
                        "ETIME",
                        "ENOSR",
                        "ENONET",
                        "ENOPKG",
                        "EREMOTE",
                        "ENOLINK",
                        "EADV",
                        "ESRMNT",
                        "ECOMM",
                        "EPROTO",
                        "EMULTIHOP",
                        "EDOTDOT",
                        "EBADMSG",
                        "EOVERFLOW",
                        "ENOTUNIQ",
                        "EBADFD",
                        "EREMCHG",
                        "ELIBACC",
                        "ELIBBAD",
                        "ELIBSCN",
                        "ELIBMAX",
                        "ELIBEXEC",
                        "EILSEQ",
                        "ERESTART",
                        "ESTRPIPE",
                        "EUSERS",
                        "ENOTSOCK",
                        "EDESTADDRREQ",
                        "EMSGSIZE",
                        "EPROTOTYPE",
                        "ENOPROTOOPT",
                        "EPROTONOSUPPORT",
                        "ESOCKTNOSUPPORT",
                        "EOPNOTSUPP/ENOTSUP",
                        "EPFNOSUPPORT",
                        "EAFNOSUPPORT",
                        "EADDRINUSE",
                        "EADDRNOTAVAIL",
                        "ENETDOWN",
                        "ENETUNREACH",
                        "ENETRESET",
                        "ECONNABORTED",
                        "ECONNRESET",
                        "ENOBUFS",
                        "EISCONN",
                        "ENOTCONN",
                        "ESHUTDOWN",
                        "ETOOMANYREFS",
                        "ETIMEDOUT",
                        "ECONNREFUSED",
                        "EHOSTDOWN",
                        "EHOSTUNREACH",
                        "EALREADY",
                        "EINPROGRESS",
                        "ESTALE",
                        "EUCLEAN",
                        "ENOTNAM",
                        "ENAVAIL",
                        "EISNAM",
                        "EREMOTEIO",
                        "EDQUOT",
                        "ENOMEDIUM",
                        "EMEDIUMTYPE",
                        "ECANCELED",
                        "ENOKEY",
                        "EKEYEXPIRED",
                        "EKEYREVOKED",
                        "EKEYREJECTED",
                        "EOWNERDEAD",
                        "ENOTRECOVERABLE",
                        "ERFKILL",
                        "EHWPOISON"};


__attribute__((__noreturn__)) void terminate(bool useExit3) {
  char *s;

  /* Dump core if EF_DUMPCORE environment variable is defined and
     is a nonempty string; otherwise call exit(3) or _exit(2),
     depending on the value of 'useExit3'. */

  s = getenv("EF_DUMPCORE");

  if (s != NULL && *s != '\0')
    abort();
  else if (useExit3)
    exit(EXIT_FAILURE);
  else
    _exit(EXIT_FAILURE);
}


/* Diagnose 'errno' error by:

      * outputting a string containing the error name (if available
        in 'ename' array) corresponding to the value in 'err', along
        with the corresponding error message from strerror(), and

      * outputting the caller-supplied error message specified in
        'format' and 'ap'. */

void outputError(bool useErr, int err, bool flushStdout,
                        const char *format, va_list ap) {
#define BUF_SIZE 500
  char buf[BUF_SIZE], userMsg[BUF_SIZE], errText[BUF_SIZE];

  vsnprintf(userMsg, BUF_SIZE, format, ap);

  if (useErr)
    snprintf(errText, BUF_SIZE, " [%s %s]",
             (err > 0 && err <= MAX_ENAME) ? ename[err] : "?UNKNOWN?",
             strerror(err));
  else
    snprintf(errText, BUF_SIZE, ":");

#if __GNUC__ >= 7
#pragma GCC diagnostic ignored "-Wformat-truncation"
#pragma GCC diagnostic push
#endif
  snprintf(buf, BUF_SIZE, "ERROR%s %s\n", errText, userMsg);
#if __GNUC__ >= 7
#pragma GCC diagnostic pop
#endif

  if (flushStdout)
    fflush(stdout); /* Flush any pending stdout */
  fputs(buf, stderr);
  fflush(stderr); /* In case stderr is not line-buffered */
}

void fatal(const char *format, ...) {
  va_list argList;

  va_start(argList, format);
  outputError(false, 0, true, format, argList);
  va_end(argList);

  terminate(true);
}


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

void err_exit(const char *format, ...) {
  va_list argList;

  va_start(argList, format);
  outputError(true, errno, false, format, argList);
  va_end(argList);

  terminate(false);
}





