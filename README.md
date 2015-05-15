NaturalSort
===========

Sort a list naturally.

Sort functions will not, generally, sort strings containing
numbers the same way a human would.

Given a list:

```
["a10",  "a05c",  "a1",  "a",  "a2",  "a1a",  "a0",  "a1b",  "a20"]
```

Applying standard sort will produce:

```
["a", "a0", "a05c", "a1", "a10", "a1a", "a1b", "a2", "a20"]
```

But applying a natural sort will give:

```
["a", "a0", "a1", "a1a", "a1b", "a2", "a05c", "a10", "a20"]
```

## Functions

### `NaturalSort.sort(list, case_sensitive? \\ false)`

Sorts a list of strings (ascending).
This works by leveraging Elixir's
`Enum.sort_by/3` function (which takes as the second argument
a mapping function). The mapping operation converts each string
into a list of strings and integers. Once in this form, applying
the sort function results in a correctly sorted list.

```
iex> NaturalSort.sort(["x2-y7", "x8-y8", "x2-y08", "x2-g8" ])
["x2-g8", "x2-y7", "x2-y08", "x8-y8" ]

iex> NaturalSort.sort(["foo03.z", "foo45.D", "foo06.A", "foo"], true)
["foo", "foo03.z", "foo06.A", "foo45.D"]
```

### `NaturalSort.sort_asc(list, case_sensitive? \\ false)`

Direct alias for `NaturalSort.sort(list, case_sensitive? \\ false)`.


### `NaturalSort.sort_desc(list, case_sensitive? \\ false)`

Sorts a list in descending order, rather than ascending
as is the default for `NaturalSort.sort`.

```
iex> NaturalSort.sort_desc(["a5", "a400", "a1"])
["a400", "a5", "a1"]
```

## Prior art:

[VersionEye's naturalsorter gem](https://github.com/versioneye/naturalsorter)
was the inspiration, with that being based on
[Martin Pool's natural sorting algorithm](http://sourcefrog.net/projects/natsort/), and making direct use of the Ruby implementation of the original
C version.
