# MadLisp - Lisp &hearts; PHP

MadLisp is a [Lisp](https://en.wikipedia.org/wiki/Lisp_%28programming_language%29) interpreter written in PHP by [Pekka Laiho](http://laihoconsulting.com/). It is inspired by the [Make a Lisp](https://github.com/kanaka/mal) project, but does not follow that convention or syntax strictly. It provides a fun platform for learning [functional programming](https://en.wikipedia.org/wiki/Functional_programming).

## Goals

* REPL environment where the user can interactively experiment with the language. Suitable for executing pieces of code one by one and examining the internal state of the system.
* Minimal safeguards or restrictions as to what can be done. Breaking things or using the language in unexpected ways should be part of the fun.
* Performance does not need to match commercial-grade languages, but needs to be fast enough for real-world programs and uses cases.
* Suitable to be used as a scripting language in Linux shell scripts and similar environments.
* Suitable to be used as an embedded scripting language inside another PHP application.
* Clear and intuitive error messages. This is important for pleasant user experience.
* Provide a library with commonly used features such as HTTP requests, JSON processing and SQL database support.
* Provide a clean interface for extending the language with your own functions defined in PHP.
* Provide a safe-mode where access to the file system and other external I/O is restricted.
* Provide a debug mode which shows what is happening inside the code evaluation.
* Loosely respect the Lisp legacy with things like naming conventions but do not be constrained by it.

## Non-goals

* Ability to call arbitrary PHP functions directly. The language should have control over which PHP functions can be called and how.
* Namespaces or similar mechanisms. The global namespace is a feature, not a bug! Use a prefix for your function names if this becomes a problem.
* Support for classes and object-oriented programming.

## Requirements

The project requires PHP 7.4 or newer and [Composer](https://getcomposer.org/).

## Code

The [repository](https://bitbucket.org/maddy83/madlisp/) is hosted on Bitbucket.

## License

MadLisp is licensed under the [MIT](https://bitbucket.org/maddy83/madlisp/src/master/LICENSE) license.
