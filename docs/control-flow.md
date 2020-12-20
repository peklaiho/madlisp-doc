# Control flow

The language contains multiple special forms for managing control flow.

## Do

You can evaluate multiple expressions together using `do`:

```text
> (do (print "Number: ") (+ 1 2))
Number: 3
```

The value of the whole expression is the value of the last expression.

## If

Conditional evaluation is accomplished with the `if` expression which is of the form `(if test consequent alternate)`. If *test* evaluates to truthy value, *consequent* is evaluated and returned. If *test* evaluates to falsy value, *alternate* is evaluated and returned:

```text
> (if (< 1 2) "yes" "no")
"yes"
```

If *alternate* is not provided, null is returned in its place:

```text
> (if (str? 1) "string")
null
```

## And, or

The `and` form returns the first expression that evaluates to falsy value:

```text
> (and 2 true "str" 0 3)
0
```

The `or` form returns the first expression that evaluates to truthy value:

```text
> (or 0 false 3 5)
3
```

Without arguments `and` and `or` return true and false respectively:

```text
> (and)
true
> (or)
false
```

## Cond, case and case-strict

When you have more than two possible paths of execution, it is convenient to use the `cond` and `case` forms.

Consider the following defined for these examples:

```text
> (def n 4)
4
```

For `cond`, the first item of each argument is evaluated. If it evaluates to truthy value, the following expression is evaluated and returned:

```text
> (cond ((= n 2) "two") ((= n 4) "four") ((= n 6) "six"))
"four"
```

For `case`, the first argument is evaluated, and then it is matched against the first item of the remaining arguments. If there is a match, the following expression is evaluated and returned:

```text
> (case (% n 2) (0 "even") (1 "odd"))
"even"
```

Note that the values to match against, `0` and `1` in the above example, are not evaluated.

The `case-strict` is similar, but uses strict comparison:

```text
> (case n ("4" "string") (4 "integer"))
"string"
> (case-strict n ("4" "string") (4 "integer"))
"integer"
```

Both `cond` and `case` can have an `else` form which is matched if nothing else matched up to that point:

```text
> (cond ((< n 2) "small") (else "big"))
"big"
> (case (% n 2) (1 "odd") (else "even"))
"even"
```

Both `cond` and `case` can have more than one expression which is evaluated after a successful match:

```text
> (cond ((int? n) (print "Number: ") n))
Number: 4
```

The arguments to `cond` and `case` can be also be given as vectors:

```text
> (cond [(int? n) "integer"] [else "other"])
"integer"
```

If no match is found, and `else` is not defined, `cond` and `case` return null.

## While

Looping is accomplished with the `while` expression which is of the form `(while test expr1 expr2 ...)`. The *test* is evaluated at the beginning of each iteration and if it returns truthy value, the remaining expressions are evaluated. The value of the whole expression is the value of the last evaluated sub-expression.

```text
> (let (i 5) (while (> i 0) (print i) (def i (dec i))))
543210
```

Although the above example illustrates how to use `while`, this type of code is discouraged. Generally it is recommended to use recursion instead of iteration in these type of scenarios. Usually it results in cleaner code as well. The `while` expression is better suited for something like the main loop of a program.
