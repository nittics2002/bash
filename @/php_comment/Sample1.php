<?php

namespace dev/excel;

use RuntimeException;

class ClassName
{
    /**
     * コメントあり
     *
     */
    public function func1()
    {

    }

    public function foo(int $arg1, &$arg2, $arg3 = [])
    {
        // method body
    }

    /**
     * コメントあり
     *
     */
    public function bar(int $arg1, &$arg2, $arg3 = [])
    {
        // method body
    }

    public function aVeryLongMethodName(
        ClassTypeHint $arg1,
        &$arg2,
        array $arg3 = []
    ) {
        // method body
    }    

    public function functionName(int $arg1, $arg2): string
    {
        return 'foo';
    }

    public function anotherFunction(
        string $foo,
        string $bar,
        int $baz
    ): string {
        return 'foo';
    }
}