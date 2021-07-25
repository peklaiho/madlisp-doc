# Built-in functions

The language comes with lots of built-in functions. The goal is to provide a "batteries included" experience for developers.

## Core functions

Name   | Example | Example result | Description
------ | ------- | -------------- | -----------
debug  | `(debug)` | `true` |  Toggle debug output. Disabled in safe-mode.
doc    | `(doc +)` | `"Return the sum of all arguments."` | Show the documentation string for a function.
       | `(doc myfn "Documentation string.")` | `"Documentation string."` | Set the documentation string for a function.
eval   | `(eval '(+ 1 2 3))` | `6` | Evaluate the given argument. This is actually a special form, not a function.
exit   | `(exit 1)` | | Terminate the script with given exit code using [exit](https://www.php.net/manual/en/function.exit.php). Disabled in safe-mode.
print  | `(print "hello world")` | `hello world` | Print expression on the screen. Disabled in safe-mode.
printr | `(printr "hello world")` | `"hello world"` | Print expression on the screen in readable format. Disabled in safe-mode.
prints | `(prints "hello world")` | `"\"hello world\""` | Print expression to string in readable format.
read   | `(read "(+ 1 2 3)")` | `(+ 1 2 3)` | Read a string as code and return the expression.
sleep  | `(sleep 2000)` | `null` | Sleep for the given period given in milliseconds using [usleep](https://www.php.net/manual/en/function.usleep). Disabled in safe-mode.
system | `(system "ls")` | `[0 "file1.txt\nfile2.txt\n"]` | Execute a system command and return a vector where the first item is status code and second is the output of the command as a string.
throw  | `(throw "invalid value")` | `error: "invalid value"` | Throw an exception. The given value is passed to catch. See the section Exceptions.

## Collection functions

Name    | Example | Example result | Description
------- | ------- | -------------- | -----------
hash    | `(hash "a" 1 "b" 2)` | `{"a":1 "b":2}` | Create a new hash-map.
list    | `(list 1 2 3)` | `(1 2 3)` | Create a new list.
vector  | `(vector 1 2 3)` | `[1 2 3]` | Create a new vector.
range   | `(range 2 5)` | `[2 3 4]` | Create a vector with integer values from first to argument (inclusive) to second argument (exclusive).
range   | `(range 5)` | `[0 1 2 3 4]` | Range can also be used with one argument in which case it is used as length for a vector of integers starting from 0.
ltov    | `(ltov '(1 2 3))` | `[1 2 3]` | Convert list to vector.
vtol    | `(vtol [1 2 3])` | `(1 2 3)` | Convert vector to list.
empty?  | `(empty? [])` | `true` | Return true if collection is empty, otherwise false.
get     | `(get [1 2 3] 0)` | `1` | Return the nth element from a sequence, or the corresponding value for the given key from a hash-map.
len     | `(len [1 2 3])` | `3` | Return the number of elements in a collection.
first   | `(first [1 2 3 4])` | `1` | Return the first element of a sequence. Also usable as `car`.
second  | `(second [1 2 3 4])` | `2` | Return the second element of a sequence.
penult  | `(penult [1 2 3 4])` | `3` | Return the second-last element of a sequence.
last    | `(last [1 2 3 4])` | `4` | Return the last element of a sequence.
head    | `(head [1 2 3 4])` | `[1 2 3]` | Return new sequence which contains all elements except the last.
tail    | `(tail [1 2 3 4])` | `[2 3 4]` | Return new sequence which contains all elements except the first. Also usable as `cdr`.
slice   | `(slice [1 2 3 4 5] 1 3)` | `[2 3 4]` | Return a slice of the sequence using offset and length. Uses [array_slice](https://www.php.net/manual/en/function.array-slice.php).
apply   | `(apply + 1 2 [3 4])` | `10` | Call the first argument using a sequence as argument list. Intervening arguments are prepended to the list.
chunk   | `(chunk [1 2 3 4 5] 2)` | `[[1 2] [3 4] [5]]` | Divide a sequence to multiple sequences with specified length using [array_chunk](https://www.php.net/manual/en/function.array-chunk.php).
concat  | `(concat [1 2] '(3 4))` | `(1 2 3 4)` | Concatenate multiple sequences together and return them as a list.
push    | `(push [1 2] 3 4)` | `[1 2 3 4]` | Create new sequence by inserting arguments at the end.
cons    | `(cons 1 2 [3 4])` | `[1 2 3 4]` | Create new sequence by inserting arguments at the beginning.
map     | `(map (fn (a) (* a 2)) [1 2 3])` | `[2 4 6]` | Create new sequence by calling a function for each item. Uses [array_map](https://www.php.net/manual/en/function.array-map.php) internally.
map2    | `(map2 + [1 2 3] [4 5 6])` | `[5 7 9]` | Create new sequence by calling a function for each item from both sequences.
reduce  | `(reduce + [2 3 4] 1)` | `10` | Reduce a sequence to a single value by calling a function sequentially of all arguments. Optional third argument is used to give the initial value for first iteration. Uses [array_reduce](https://www.php.net/manual/en/function.array-reduce.php) internally.
filter  | `(filter odd? [1 2 3 4 5])` | `[1 3 5]` | Create a new sequence by using the given function as a filter. Uses [array_filter](https://www.php.net/manual/en/function.array-filter.php) internally.
filterh | `(filterh (fn (v k) (prefix? k "a")) {"aa":1 "ab":2 "bb":3})` | `{"aa":1 "ab":2}` | Same as filter but for hash-maps. First argument passed to the callback is the value and second is the key.
reverse | `(reverse [1 2 3])` | `[3 2 1]` | Reverse the order of a sequence. Uses [array_reverse](https://www.php.net/manual/en/function.array-reverse.php) internally.
key?    | `(key? {"a" "b"} "a")` | `true` | Return true if the hash-map contains the given key.
set     | `(set {"a" 1} "b" 2)` | `{"a":1 "b":2}` | Create new hash-map which contains the given key-value pair.
set!    | `(set! {"a" 1} "b" 2)` | `2` | Modify the given hash-map by setting the given key-value pair and return the set value. **This function is mutable!**
unset   | `(unset {"a":1 "b":2 "c":3} "b")` | `{"a":1 "c":3}` | Create a new hash-map with the given key removed.
unset!  | `(unset! {"a":1 "b":2 "c":3} "b")` | `2` | Modify the given hash-map by removing the given key and return the corresponding value. **This function is mutable!**
keys    | `(keys {"a" 1 "b" 2})` | `("a" "b")` | Return a list of the keys for a hash-map.
values  | `(values {"a" 1 "b" 2})` | `(1 2)` | Return a list of the values for a hash-map.
zip     | `(zip ["a" "b"] [1 2])` | `{"a":1 "b":2}` | Create a hash-map using the first sequence as keys and the second as values. Uses [array_combine](https://www.php.net/manual/en/function.array-combine.php) internally.
sort    | `(sort [6 4 8 1])` | `[1 4 6 8]` | Sort the sequence using [sort](https://www.php.net/manual/en/function.sort.php).
usort   | `(usort (fn (a b) (if (< a b) 0 1)) [3 1 5 4 2])` | `[1 2 3 4 5]` | Sort the sequence using custom comparison function using [usort](https://www.php.net/manual/en/function.usort.php).

## Comparison functions

Name    | Example | Example result | Description
------- | ------- | -------------- | -----------
=     | `(= 1 "1")` | `true` | Compare arguments for equality using the `==` operator in PHP.
==    | `(== 1 "1")` | `false` | Compare arguments for strict equality using the `===` operator in PHP.
!=    | `(!= 1 "1")` | `false` | Compare arguments for not-equality using the `!=` operator in PHP.
!==   | `(!== 1 "1")` | `true` | Compare arguments for strict not-equality using the `!==` operator in PHP.
&lt;  | `(< 1 2)` | `true` | Return true if first argument is less than second.
&lt;= | `(<= 1 2)` | `true` | Return true if first argument is less or equal to second.
&gt;  | `(> 1 2)` | `false` | Return true if first argument is greater than second.
&gt;= | `(>= 1 2)` | `false` | Return true if first argument is greater or equal to second.

## Crypto and hash functions

Name        | Example | Example result | Description
----------- | ------- | -------------- | -----------
md5         | `(md5 "test")` | `"098f6b..."` | Calculate the MD5 hash of a string.
sha1        | `(sha1 "test")` | `"a94a8f..."` | Calculate the SHA1 hash of a string.
pw-hash     | `(pw-hash "test")` | `"$2y$10$..."` | Calculate the hash for a password using [password_hash](https://www.php.net/manual/en/function.password-hash.php).
pw-verify   | `(pw-verify "test" "hash")` | `false` | Verify a password hash using [password_verify](https://www.php.net/manual/en/function.password-verify.php).

## Database functions

This is a simple wrapper for [PDO](https://www.php.net/manual/en/book.pdo.php). This library is disabled in safe-mode.

Name        | Example | Example result | Description
----------- | ------- | -------------- | -----------
db-open     | `(def d (db-open "mysql:host=localhost;dbname=test" "testuser" "testpw"))` | `<object<PDO>>` | Open a database connection.
db-execute  | `(db-execute d "INSERT INTO test_table (col1, col2) values (?, ?)" [1 2])` | `1` | Execute a SQL statement and return the number of affected rows.
db-query    | `(db-query d "SELECT * FROM test_table WHERE col1 = ?" [1])` | | Execute a SELECT statement.
db-last-id  | `(db-last-id d)` | `"1"` | Return the last id of auto-increment column.
db-trans    | `(db-trans d)` | `true` | Start a transaction.
db-commit   | `(db-commit d)` | `true` | Commit a transaction.
db-rollback | `(db-rollback d)` | `true` | Roll back a transaction.

## Encoding and decoding functions

All of these functions take a single string as argument.

Name        | Description
----------- | -----------
bin2hex | Convert binary data to hexadecimal representation.
hex2bin | Decode a hexadecimally encoded binary string.
to-base64 | Encode binary data to Base64 representation.
from-base64 | Decode a Base64 encoded binary string.
url-encode | Encode special characters in URL.
url-decode | Decode special characters in URL.
utf8-encode | Encode ISO-8859-1 string to UTF-8.
utf8-decode | Decode UTF-8 string to ISO-8859-1.

## Http functions

This is a simple wrapper for [cURL](https://www.php.net/manual/en/book.curl.php). This library is disabled in safe-mode.

Name        | Example | Example result | Description
----------- | ------- | -------------- | -----------
http        | `(http "POST" "http://example.com/" (to-json {"key":"value"}) {"Content-Type":"application/json"})` | `{"status":200 "body":"" "headers":{}}` | Perform a HTTP request. First argument is the HTTP method, second is URL, third is request body and fourth is headers as a hash-map. The function returns a hash-map which contains keys `status`, `body` and `headers`.

## IO functions

This library is disabled in safe-mode.

Name    | Example | Example result | Description
------- | ------- | -------------- | -----------
wd      | `(wd)` | `"/home/user/madlisp/"` | Get the current working directory.
chdir   | `(chdir "/tmp")` | `true` | Change the current working directory.
file?   | `(file? "test.txt")` | `true` | Return true if the file exists.
dir?    | `(dir? "test.txt")` | `false` | Return true if directory exists and is not a file.
fsize   | `(fsize "test.txt")` | `4` | Return the size of a file in bytes.
ftime   | `(ftime "test.txt")` | `1608539455` | Return the modification time of a file as Unix timestamp.
ftouch  | `(ftouch "test.txt")` | `true` | Update the modification time of a file.
fperms  | `(fperms "test.txt")` | `"0644"` | Get the file permissions of a file.
fmod    | `(fmod "test.txt" "0666")` | `true` | Set the file permissions of a file.
fown    | `(fown "test.txt")` | `"user"` | Get the owner of a file.
fgrp    | `(fgrp "test.txt")` | `"group"` | Get the group of a file.
fcache  | `(fcache)` | `null` | Clear the cache of file information (permissions, modification time, size) using [clearstatcache](https://www.php.net/manual/en/function.clearstatcache.php).
fdel    | `(fdel "test.txt")` | `true` | Delete a file.
fget    | `(fget "test.txt")` | `"content"` | Read the contents of a file using [file_get_contents](https://www.php.net/manual/en/function.file-get-contents.php).
fput    | `(fput "test.txt" "content")` | `true` | Write string to file using [file_put_contents](https://www.php.net/manual/en/function.file-put-contents.php). Give optional third parameter as `true` to append.
fopen   | `(def f (fopen "test.txt" "w"))` | `<resource>` | Open a file for reading or writing. Give the mode as second argument.
fclose  | `(fclose f)` | `true` | Close a file resource.
fwrite  | `(fwrite f "abc")` | `3` | Write to a file resource.
fflush  | `(fflush f)` | `true` | Persist buffered writes to disk for a file resource.
fread   | `(fread f 16)` | `"abc"` | Read from a file resource.
feof?   | `(feof? f)` | `true` | Return true if end of file has been reached for a file resource.
glob    | `(glob "src/*.php")` | `["src/a.php" "src/b.php"]` | Find all files matching the given pattern.
read-dir | `(read-dir "txt")` | `["." ".." "a.txt" "b.txt"]` | List all files from a directory.

The following functions are available if the [readline](https://www.php.net/manual/en/book.readline.php) extension is loaded:

Name    | Example | Example result | Description
------- | ------- | -------------- | -----------
readline | `(readline "What is your name? ")` | `What is your name? ` | Read line of user input using [readline](https://www.php.net/manual/en/function.readline.php).
readline-add | `(readline-add "What is your name? ")` | `true` | Add line of user input to readline history using [readline_add_history](https://www.php.net/manual/en/function.readline-add-history.php).
readline-load | `(readline-load "historyfile")` | `true` | Read readline history from file using [readline_read_history](https://www.php.net/manual/en/function.readline-read-history.php).
readline-save | `(readline-save "historyfile")` | `true` | Write readline history into file using [readline_write_history](https://www.php.net/manual/en/function.readline-write-history.php).

## Json functions

Name    | Example | Example result | Description
------- | ------- | -------------- | -----------
to-json | `(to-json { "a" [1 2 3] "b" [4 5 6] })` | `"{\"a\":[1,2,3],\"b\":[4,5,6]}"` | Encode the argument as a JSON string.
from-json | `(from-json "{\"a\":[1,2,3],\"b\":[4,5,6]}")` | `{"a":[1 2 3] "b":[4 5 6]}` | Decode the JSON string given as argument.

## Math functions

Name    | Example | Example result | Description
------- | ------- | -------------- | -----------
\+    | `(+ 1 2 3)` | `6` | Return the sum of the arguments.
\-    | `(- 4 2 1)` | `1` | Subtract the other arguments from the first.
\*    | `(* 2 3 4)` | `24` | Multiply the arguments.
/     | `(/ 7 2)` | `3.5` | Divide the arguments.
//    | `(// 7 2)` | `3` | Divide the arguments using integer division.
%     | `(% 6 4)` | `2` | Calculate the modulo.
inc   | `(inc 1)` | `2` | Increment the argument by one.
dec   | `(dec 2)` | `1` | Decrement the argument by one.
sin   | `(sin 1)` | `0.84` | Calculate the sine.
cos   | `(cos 1)` | `0.54` | Calculate the cosine.
tan   | `(tan 1)` | `1.55` | Calculate the tangent.
abs   | `(abs -2)` | `2` | Get the absolute value.
floor | `(floor 2.5)` | `2` | Get the next lowest integer.
ceil  | `(ceil 2.5)` | `3` | Get the next highest integer.
max   | `(max 3 6 4)` | `6` | Return the largest value.
max   | `(max [3 6 4])` | `6` | Max can also be used with a sequence.
min   | `(min 4 2 5)` | `2` | Return the smallest value.
min   | `(min [4 2 5])` | `2` | Min can also be used with a sequence.
pow   | `(pow 2 4)` | `16` | Raise the first argument to the power of the second argument.
sqrt  | `(sqrt 2)` | `1.41` | Calculate the square root.
rand  | `(rand 5 10)` | `8` | Return a random integer between given min and max values.
randf | `(randf)` | `0.678` | Return a random float between 0 (inclusive) and 1 (exclusive).
rand-seed | `(rand-seed 256)` | `256` | Seed the random number generator with the given value.
rand-bytes | `(rand-bytes 4)` | `"abcd"` | Get random binary data of the given length.

## Regular expression functions

Name          | Example | Example result | Description
------------- | ------- | -------------- | -----------
re-match      | `(re-match "/^[a-z]{4}[0-9]{4}$/" "test1234")` | `true` | Match subject to regular expression using [preg_match](https://www.php.net/manual/en/function.preg-match.php).
              | `(re-match "/[a-z]{5}/" "one three five" true)` | `"three"` | Give true as third argument to return the matched text.
re-match-all  | `(re-match-all "/[A-Z][a-z]{2}[0-9]/" "One1 Two2 Three3")` | `["One1" "Two2"]` | Find multiple matches to regular expression using [preg_match_all](https://www.php.net/manual/en/function.preg-match-all.php).
re-replace    | `(re-replace "/year ([0-9]{4}) month ([0-9]{2})/" "$1-$2-01" "year 2020 month 10")` | `"2020-10-01"` | Perform search and replace with regular expression using [preg_replace](https://www.php.net/manual/en/function.preg-replace.php).
re-split      | `(re-split "/\\s+/" "aa   bb   cc   ")` | `["aa" "bb" "cc"]` | Split the subject by regular expression using [preg_split](https://www.php.net/manual/en/function.preg-split.php). The flag `PREG_SPLIT_NO_EMPTY` is enabled.

## String functions

Name    | Example | Example result | Description
------- | ------- | -------------- | -----------
empty?  | `(empty? "")` | `true` | Return true if argument is empty string.
len     | `(len "hello world")` | `11` | Return the length of a string using [strlen](https://www.php.net/manual/en/function.strlen.php).
reverse | `(reverse "hello world")` | `"dlrow olleh"` | Reverse the characters of a string using [strrev](https://www.php.net/manual/en/function.strrev.php).
trim    | `(trim " abc ")` | `"abc"` | Trim the string using [trim](https://www.php.net/manual/en/function.trim).
ltrim   | `(ltrim " abc ")` | `"abc "` | Trim the beginning of string using [ltrim](https://www.php.net/manual/en/function.ltrim).
rtrim    | `(rtrim " abc ")` | `" abc"` | Trim the end of string using [rtrim](https://www.php.net/manual/en/function.rtrim).
upcase  | `(upcase "abc")` | `"ABC"` | Make the string upper case using [strtoupper](https://www.php.net/manual/en/function.strtoupper).
lowcase | `(lowcase "Abc")` | `"abc"` | Make the string lower case using [strtolower](https://www.php.net/manual/en/function.strtolower.php).
strpos  | `(strpos "hello world" "llo")` | `2` | Return the index of the second string in the first string, or false if not found, using [strpos](https://www.php.net/manual/en/function.strpos.php).
stripos | `(stripos "hello world" "LLO")` | `2` | Case-insensitive version of `strpos`.
substr  | `(substr "hello world" 3 5)` | `"lo wo"` | Get a substring using [substr](https://www.php.net/manual/en/function.substr.php).
replace | `(replace "hello world" "hello" "bye")` | `"bye world"` | Replace substrings using [str_replace](https://www.php.net/manual/en/function.str-replace.php).
split   | `(split "-" "a-b-c")` | `["a" "b" "c"]` | Split string using [explode](https://www.php.net/manual/en/function.explode.php).
join    | `(join "-" "a" "b" "c")` | `"a-b-c"` | Join string together using [implode](https://www.php.net/manual/en/function.implode.php).
format  | `(format "%d %.2f" 56 4.5)` | `"56 4.50"` | Format string using [sprintf](https://www.php.net/manual/en/function.sprintf.php).
prefix? | `(prefix? "hello world" "hello")` | `true` | Return true if the first argument starts with the second argument.
suffix? | `(suffix? "hello world" "world")` | `true` | Return true if the first argument ends with the second argument.
strcmp | | | Compare two strings using [strcmp](https://www.php.net/manual/en/function.strcmp.php).
strcasecmp | | | Compare two strings using [strcasecmp](https://www.php.net/manual/en/function.strcasecmp.php).
strnatcmp | | | Compare two strings using [strnatcmp](https://www.php.net/manual/en/function.strnatcmp.php).
strnatcasecmp | | | Compare two strings using [strnatcasecmp](https://www.php.net/manual/en/function.strnatcasecmp.php).

The following functions are available if the [mbstring](https://www.php.net/manual/en/book.mbstring.php) extension is loaded:

Name       | Description
---------- | -----------
mb-len     | Return the length of a multibyte string in characters.
mb-upcase  | Multibyte version of `upcase`.
mb-lowcase | Multibyte version of `lowcase`.
mb-strpos  | Multibyte version of `strpos`.
mb-stripos | Multibyte version of `stripos`.
mb-substr  | Multibyte version of `substr`.

## Time functions

Name    | Example | Example result | Description
------- | ------- | -------------- | -----------
time | `(time)` | `1592011969` | Return the current unix timestamp using [time](https://www.php.net/manual/en/function.time).
mtime | `(mtime)` | `1607696761.132` | Return the current unix timestamp as float that includes microseconds. Uses [microtime](https://www.php.net/manual/en/function.microtime).
date | `(date "Y-m-d H:i:s")` | `"2020-06-13 08:33:29"` | Format the current time and date using [date](https://www.php.net/manual/en/function.date.php).
strtotime | `(strtotime "2020-06-13 08:34:47")` | `1592012087` | Parse datetime string into unix timestamp using [strtotime](https://www.php.net/manual/en/function.strtotime.php).

## Type functions

Skipped examples here as these are pretty self-explanatory.

Name    | Description
------- | -----------
bool | Convert the argument to boolean.
float | Convert the argument to floating-point value.
int | Convert the argument to integer.
str | Convert the argument to string. Also concatenate multiple strings together.
symbol | Convert the argument to symbol.
not | Turns true to false and vice versa.
type | Return the type of the argument as a string.
fn? | Return true if the argument is a function.
macro? | Return true if the argument is a macro.
list? | Return true if the argument is a list.
vector? | Return true if the argument is a vector.
seq? | Return true if the argument is a sequence (list or vector).
hash? | Return true if the argument is a hash-map.
symbol? | Return true if the argument is a symbol.
object? | Return true if the argument is an object.
resource? | Return true if the argument is a resource.
bool? | Return true if the argument is a boolean value (strict comparison).
true? | Return true if the argument evaluates to true (non-strict comparison).
false? | Return true if the argument evaluates to false (non-strict comparison).
null? | Return true if the argument is null (strict comparison).
int? | Return true if the argument is an integer.
float? | Return true if the argument is a floating-point value.
str? | Return true if the argument is a string.
zero? | Return true if the argument is integer 0 (strict comparison).
one? | Return true if the argument is integer 1 (strict comparison).
even? | Return true if the argument is even number (0, 2, 4, ...).
odd? | Return true if the argument is odd number (1, 3, 5, ...).
