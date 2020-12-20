# Basic types

## Numbers

Numeric literals are interpreted as integer or floating point values. For example `1` or `1.0`.

## Strings

Strings are limited by double quotes, for example `"this is a string"`.

## Comments

Comments start with semicolon `;` and end on a newline character.

## Keywords

Special keywords are `true`, `false` and `null` which correspond to same PHP values.

## Sequences

Lists are limited by parenthesis. They can be defined using the built-in `list` function:

```text
> (list 1 2 3)
(1 2 3)
```

Vectors are defined using square brackets or the built-in `vector` function:

```text
> [1 2 3]
[1 2 3]

> (vector 4 5 6)
[4 5 6]
```

Internally lists and vectors are just PHP arrays wrapped in a class, and the only difference between the two is how they are evaluated. Another reason for adding vectors is the familiarity of the square bracket syntax for PHP developers. They can be thought of as numerically-indexed PHP arrays for most intents and purposes.

## Hash maps

Hash maps are collections of key-value pairs. Keys are normal strings, not "keywords" starting with colon characters as in some other Lisp languages.

Hash maps are defined using curly brackets or using the built-in `hash` function. Odd arguments are treated as keys and even arguments are treated as values. The key-value pair can optionally include colon as a separator to make it more readable, but it is ignored internally.

```text
> (hash "a" 1 "b" 2)
{"a":1 "b":2}

> {"key":"value"}
{"key":"value"}
```

Internally hash maps are just regular associative PHP arrays wrapped in a class.

## Symbols

Symbols are words which do not match any other type and are separated by whitespace. They can contain special characters. Examples of symbols are `a`, `name` or `+`.

Symbols are evaluated by looking up the corresponding value from the current environment.
