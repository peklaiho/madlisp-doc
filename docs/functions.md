# Functions

Functions are created using the `fn` special form, also known as `lambda` in other Lisp languages:

```text
> (fn (a b) (+ a b))
<function>
```

The first argument to `fn` is a list of bindings which are used as arguments to the created function. The second argument is the function body.

A function is applied or "called" when a list is evaluated. The function is the first item of the list and the remaining items are arguments to the function. When a function is applied, a new environment is created where the bindings are bound to the given arguments, and the function body is then evaluated in this new environment.

We can apply the above function directly by putting it inside a list and giving it some arguments:

```text
> ((fn (a b) (+ a b)) 1 2)
3
```

More commonly we define a function in the environment first, essentially giving it a "name", and then apply it separately:

```text
> (def add (fn (a b) (+ a b)))
<function>
> (add 1 2)
3
```

Note that trying to evaluate a list which does not contain a function as the first item is an error:

```text
> ("string" 1 2)
error: eval: first item of list is not function
```

A function can take variable number of arguments. In this case, the bindings list contains a `&` character and one symbol after it. The remaining arguments are bound to this symbol as a vector:

```text
> ((fn (a b & c) c) 1 2 3 4 5)
[3 4 5]
```

Finally, the bindings to `fn` can be given as a vector, if that syntax is preferred:

```text
> (fn [a b] (+ a b))
<function>
```
