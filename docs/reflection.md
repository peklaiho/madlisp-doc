# Reflection

You can use the `meta` special form to retrieve the arguments, body, code or full definition of user-defined functions:

```text
> (defn add (a b) (+ a b))
<function>

> (meta add "args")
(a b)
> (meta add "body")
(+ a b)
> (meta add "code")
(fn (a b) (+ a b))
> (meta add "def")
(defn add (a b) (+ a b))
```

This allows for some fun tricks. For example, we can retrieve the body of a function and evaluate it as part of another function:

```text
> (defn addOne (n) (+ n 1))
<function>
> (defn addTwo (n) (+ n 2))
<function>
> (defn addBoth (n) (+ (eval (meta addOne "body")) (eval (meta addTwo "body"))))
<function>
> (addBoth 1)
5
```
