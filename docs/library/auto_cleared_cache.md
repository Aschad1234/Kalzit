# auto_cleared_cache
## argumentList
fullTimeMillis
## comment

Creates a modifiable object (See documentation of ModifiableObject for more detail) whose values are automatically removed after a set amount of time.
This makes it useful for cacheing things that do not change often, but sometimes.

If you want to create a modifiable object that gets cleared every ten seconds, you can do this:

autoClearedCache: 10000 `Time is specified in milliseconds`
