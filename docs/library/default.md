# default
## argumentList
_value
_type
## comment

A function that helps you define a default value, in case void (the empty list) is given.
You can provide a default value and an optional type, and the resulting type function will replace void with the default value.
The result is then converted using the type function.

Example: (default: 5): 9 `Result is 9`
However: (default: 5): void `Result is 5`

This would also work:
(5 default 2 SizedList Int): void `Result is (5;5) - the type function is applied to the default value`
