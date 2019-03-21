+++
title="F# Active Patterns and C# Interop"
date=2019-03-20
+++

As you may or may not know F# has a very useful feature for interoperating with the common C# `TryGetValue` pattern.
<!-- more -->
```c#
if (collection.TryGetValue("key", out T value) { ... }
```

In F# you can, instead, treat the rturn valuea as a tuple of type `bool*'a`.  This is very helpful and works well with pattern matching
```fsharp
match collection.TryGetValue("key") with
| true, value -> printfn "Got value %s" value
| false, _ -> printfn "Value not found"
```

Another common pattern in F# is to create a temporary tuple when you have multiple items to match on.
```fsharp
match isCool, isSmelly with
| true, true -> "Whoa, gross!"
| false, true -> "Ewww... gross."
| true, false ->  "Whoa, awesome!"
| false, false -> "Whatever"
```
This works great but it gets a little awkward when you combine it with the TryGetValue pattern because now you're matching on a tuple of tuples and things get a little messy.
```fsharp
match collection.TryGetValue("value1"), collection.TryGetValue("value2") with
| (true, val1), (true, val2) -> ...
| (true, val1), (false, _) -> ...
| (false, _), (true, val2) -> ...
| (false, _), (false, _) ->...
```

**Enter active patterns!** You can define an active pattern to give the `bool*'a` more meaning and make it easier to read.
```fsharp
let (|Found|NotFound|) (b:bool,v:'a) = if b then Found v else NotFound
match collection.TryGetValue("value1"), collection.TryGetValue("value2") with
| Found val1, Found val2 -> ...
| Found val1, NotFound -> ...
| NotFound, Found val2 -> ...
| NotFound, NotFound -> ...
```

# Another Example

Sometimes you have a function that returns an integer wich has a specific range that is smaller than the set of all integers.  For example the IComparable interface return 0,1 or -1 to indicate equal, greater or less than.  I think it would have been a better API if it returned an enum instead of an integer because it's easier to quickly undertand the word `Lesser` than -1.  With Active patterns we can transform the intger to the word so the code is easier to read down the road.

```fsharp
let (|Equal|Greater|Lesser|) i = match sign i with | 0 -> Equal | 1 -> Greater | _ -> Less
match compare x y with
| Equal -> "x = y"
| Greater -> "x > y"
| Lesser -> "x < y"
```


# Takeaway

Active patterns are an easy way to add some semantic meaning and improve readability. They seem to work particularly well with some common idioms from C#.