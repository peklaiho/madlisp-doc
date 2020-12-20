# Init file

You can create an init file in your home directory with the name `.madlisp_init`. If present, this file is automatically executed when the interpreter is started.

The init file is useful for registering commonly used functions and performing other initialization. However, it is recommended to avoid heavy calculations, HTTP requests and similar resource-intensive operations in the init because they would slow down starting the interpreter.

The init file can be skipped by giving the `-q` option when invoking the interpreter:

```text
$ madlisp -q -r
>
```
