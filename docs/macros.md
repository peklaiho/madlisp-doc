# Macros

The language has support for Lisp-style macros. Macros are like preprocessor directives and allow the manipulation of the language syntax before evaluation.

There are two built-in macros: `defn` which is a shortcut for the form `(def ... (fn ...))` and `defmacro` which is a shortcut for the form `(def ... (macro ...))`. To illustrate how macros work, lets look at the definition of `defn`:

```text
(def defn (macro (name args body) (quasiquote (def (unquote name) (fn (unquote args) (unquote body))))))
```

We can use the special form `macroexpand` to test macro expansion without evaluating the resulting code:

```text
> (macroexpand (defn add (a b) (+ a b)))
(def add (fn (a b) (+ a b)))
```

The `quasiquote` form is essential for declaring macros. Internally macros are just functions with a special flag.

## Examples

Lets combine `if` and `not` into a macro named `unless`, this time using a shorter syntax:

```text
> (defmacro unless (pred a b) `(if (not ~pred) ~a ~b))
<macro>

> (unless (< 2 1) "false" "true")
"false"

> (macroexpand (unless (< 2 1) "false" "true"))
(if (not (< 2 1)) "false" "true")
```

For another example, we can use the lambda symbol to replace `fn`:

```text
(defmacro λ (args body) (quasiquote (fn (unquote args) (unquote body))))
<macro>

> (λ (a) (+ a 1))
<function>

> (macroexpand (λ (a) (+ a 1)))
(fn (a) (+ a 1))
```
