# Usage

There are two main ways to use the MadLisp language:

- Command line use, for shell scripts and the REPL
- Embedding the language inside another PHP application

## Command line use

The following examples assume that the `madlisp` executable is available in your PATH as instructed in the [previous section](/getting-started). Otherwise you need to replace it with the full path, e.g. `vendor/bin/madlisp`.

The interpreter can be given the `-h` or `--help` option to display all available arguments:

```text
$ madlisp --help
```

The interactive REPL can be started with the `-r` option:

```text
$ madlisp -r
>
```

A file containing MadLisp code can be evaluated by simply giving it as argument:

```text
$ madlisp file.mad
```

For convenience when evaluating simple snippets, the `-p` option can be used to print out the result.

Code to be evaluated can be given as an argument with the `-e` option:

```text
$ madlisp -p -e "(+ 1 2 3)"
6
```

With no arguments, the interpreter will read input from stdin. This can be used with pipes:

```text
$ echo "(+ 1 2 3)" | madlisp -p
6
```

Some of the options can be combined together. For example, you can evaluate a file and then enter the REPL:

```text
$ madlisp -r file.mad
>
```

However, as of this writing, short options cannot be combined together. Option parsing might be improved in future to allow this.

### Passing arguments

Command line arguments can be passed to the Lisp environment by separating them with `--`. Arguments after the separator are passed. Special variables `argc` and `argv` are defined in the environment which contain the number of arguments and their values respectively.

To demonstrate, we can create a file that just returns the arguments and then evaluate it.

```text
$ echo "(print argv)" > test.mad
$ madlisp test.mad -- abc efg 123
[abc efg 123]
```

### Shell scripts

A shell script can be set to be evaluated using MadLisp with the [Shebang](https://en.wikipedia.org/wiki/Shebang_%28Unix%29) notation.

For example, if we create a file `myexec` where the first line contains `#!` followed by the full path to the `madlisp` executable:

```text
#!/usr/bin/env madlisp
(print (+ 1 2 3))
```

Then we can make the script executable using chmod and invoke it directly:

```text
$ chmod a+x myexec
$ ./myexec
6
```

Note that for now arguments passed to Lisp still need to be separated with `--` like above.

## Embedded use

To embed MadLisp in your PHP application, use the `LispFactory` class to create an instance of `Lisp`. Then you can use the `readEval` method to evaluate Lisp code. The evaluated code can be printed to stdout by `print` or to string by `pstr` methods respectively. The print methods take a second parameter `printReadable` which, if true, will show strings in double quotes and escape special characters using backslashes. The `rep` method is a shortcut for read-eval-print.

Here is a simple example:

```php
<?php
require('vendor/autoload.php');

// Create instance of Lisp
$factory = new MadLisp\LispFactory();
$lisp = $factory->make();

// Evaluate code
$code = '(map (fn (a) (* a a)) (range 1 6))';
$result = $lisp->readEval($code);

// Print the result to string and echo it
$str_result = $lisp->pstr($result, false);
echo $str_result;
```

If we save the file as `lisp.php`, we can run it and see the result:

```text
$ php lisp.php
[1 4 9 16 25]
```

### Safe-mode

The language includes a safe-mode that disables functions which allow external I/O. This allows a "sandbox" to be created where the evaluated scripts do not have access to the file system or other resources.

The safe-mode is enabled by giving `true` as argument to the `make` method of `LispFactory`.
