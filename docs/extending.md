# Extending

You can create your own libraries with functions defined in PHP by implementing the `MadLisp\Lib\ILib` interface. The `register` method takes an environment as argument where functions can be set. The interface is defined like this:

```php
namespace MadLisp\Lib;

use MadLisp\Env;

interface ILib
{
    public function register(Env $env): void;
}
```

You can then register your library with something like this:

```php
$factory = new MadLisp\LispFactory();
$lisp = $factory->make();

$myLib = new My\Library();
$myLib->register($lisp->getEnv()->getRoot());
```

Take a look at the built-in libraries for examples.
