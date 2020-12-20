# Loading files

Files can be read and evaluated using the `load` special form. It takes one argument, which is the name of the file to load. The argument is also evaluated, so it can be a function which returns a filename.

If the filename contains the tilde character (`~`) it is expanded to the home directory of the user. The contents of the file are implicitly wrapped in a `do` expression before they are evaluated.

The special constants `__FILE__` and `__DIR__` are defined while a file is being evaluated. They are set to the filename and directory of the file respectively. They allow for other files with relative paths to the initial file to load correctly, regardless of the working directory of the user.

For example, suppose we have a file `a.mad` which loads file `b.mad` from a subdirectory:

```text
(load "lib/b.mad")
```

The file `b.mad` contains a simple print expression:

```text
(print "I am b!")
```

If we evaluate the file `a.mad` from the same directory where it is located, this will work:

```text
$ madlisp a.mad
I am b!
```

But if our working directory is not the directory where `a.mad` is located, this will fail:

```text
$ madlisp code/a.mad
PHP Fatal error:  Uncaught MadLisp\MadLispException: unable to read file lib/b.mad
```

To fix this, we should load `b.mad` with a relative path from the `a.mad` file:

```text
(load (str __DIR__ "lib/b.mad"))
```

Then everything will work again as expected:

```text
$ madlisp code/a.mad
I am b!
```
