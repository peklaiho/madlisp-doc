# Getting started

## Install Composer

Install Composer by following the instructions on their [website](https://getcomposer.org/).

## Require the package using Composer

Create a new directory and require the project using composer:

```text
$ mkdir mylisp
$ cd mylisp
$ composer require "maddy83/madlisp dev-master"
```

Use the `vendor/bin/madlisp` executable to start the interpreter. Start the REPL with the `-r` option:

```text
$ vendor/bin/madlisp -r
>
```

You can evaluate Lisp code interactively inside the REPL:

```text
> (+ 1 2 3)
6
```

## Adding the executable on your path

For convenience, it is recommended to add the directory of the `madlisp` executable to the PATH of your shell so that you can invoke it simply by typing `madlisp` from any directory.

For example, if you are using the Bash shell, and assuming the executable is in `~/mylisp/vendor/bin`, you could add the following to your `~/.bashrc` file:

```text
export PATH=~/mylisp/vendor/bin:$PATH
```
