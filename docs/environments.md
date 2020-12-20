# Environments

Environments are hash-maps which store key-value pairs and use symbols as keys. The environment is the *context* in which the Lisp code is evaluated. When the evaluation encounters a symbol, it attempts to look up the corresponding value from the environment. If the current environment does not contain a key for the given symbol, the lookup proceeds to the parent environment and so on recursively. In case the symbol is not found from the whole environment chain, an error is thrown.

The initial environment is called `root` and contains all the built-in functions. Another environment called `user` is created for anything the user wants to define.

You can define values in the environment using `def`:

```text
> (def abc 123)
123
> abc
123
> (def addOne (fn (a) (+ a 1)))
<function>
> (addOne abc)
124
```

Note that `def` always uses the current environment, so anything defined with `def` is not visible in the parent environment.

You can retrieve the current environment using `env`:

```text
> (env)
{"abc":123 "addOne":<function>}
```

You can remove a definition from the current environment using `undef`:

```text
> (undef addOne)
<function>
```

You can get the name of an environment and the parent environment using the `meta`:

```text
> (meta (env) "name")
"root/user"
> (meta (env) "parent")
{}
```

## Let

You can create a new environment using `let`. It is useful for "local variables":

```text
> (let (a 1 b 2) (+ a b))
3
```

The first argument to let is a list of bindings defined in the new environment. In this example the value of `a` is set to 1, and the value of `b` to 2. Then the body expression, `(+ a b)` in the example, is evaluated in the new environment.

The body of `let` can contain multiple expressions and the value of the whole expression is the value of the last expression:

```text
> (let (a 1 b 2) (print "Number is: ") (+ a b))
Number is: 3
```

The values of previous bindings can be used in subsequent bindings:

```text
> (let (a (+ 1 2) b (* a 2)) b)
6
```

Finally, the bindings can be given as a vector, if that syntax is preferred:

```text
> (let [a 1 b 2] (+ a b))
3
```

## Functions

Whenever a function is applied or "called", a new environment is created, and the function body is evaluated in that new environment.
