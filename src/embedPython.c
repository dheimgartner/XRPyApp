#define PY_SSIZE_T_CLEAN
#include <Python.h>

/*
 * We could write a function with Rcpp that does exactly this - takes a string,
 * and passes it to the Python API. Questions: How to persist the session, i.e.
 * evaluate several commands in the same context (Py_Initialize). Further,
 * reticulate has a communication channel from python to R.
 */

int
main(int argc, char *argv[])
{
  wchar_t *program = Py_DecodeLocale(argv[0], NULL);
  if (program == NULL) {
    fprintf(stderr, "Fatal error: cannot decode argv[0]\n");
    exit(1);
  }
  Py_SetProgramName(program);  /* optional but recommended */
  Py_Initialize();
  PyRun_SimpleString("from time import time,ctime\n"
                       "print('Today is', ctime(time()))\n");
  if (Py_FinalizeEx() < 0) {
    exit(120);
  }
  PyMem_RawFree(program);
  return 0;
}
