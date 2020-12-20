# Quoting

Use the `quote` special form to skip evaluation:

```text
> (quote (1 2 3))
(1 2 3)
```

Use the `quasiquote` special form when you need to turn on evaluation temporarily inside the quoted element. The special forms `unquote` and `unquote-splice` are available for that purpose:

```text
> (def lst (quote (2 3)))
(2 3)

> (quasiquote (1 lst 4))
(1 lst 4)
> (quasiquote (1 (unquote lst) 4))
(1 (2 3) 4)
> (quasiquote (1 (unquote-splice lst) 4))
(1 2 3 4)
```

Internally `quasiquote` expands to `cons` and `concat` functions. We can use the `quasiquote-expand` special form to test this expansion without evaluation:

```text
> (def lst (quote (2 3)))
(2 3)

> (quasiquote-expand (1 lst 4))
(cons 1 (cons (quote lst) (cons 4 ())))
> (quasiquote-expand (1 (unquote lst) 4))
(cons 1 (cons lst (cons 4 ())))
> (quasiquote-expand (1 (unquote-splice lst) 4))
(cons 1 (concat lst (cons 4 ())))
```

## Quote shortcuts

You can use the single-quote (`'`) as a shortcut for `quote`:

```text
> '(a b c)
(a b c)
```

The backtick, tilde (`~`) and `~@` can be used as shortcuts for `quasiquote`, `unquote` and `unquote-splice` respectively:

```text
> (def lst '(2 3))
(2 3)
> `(1 ~lst 4)
(1 (2 3) 4)
> `(1 ~@lst 4)
(1 2 3 4)
```

All special forms related to quoting require exactly one argument.
