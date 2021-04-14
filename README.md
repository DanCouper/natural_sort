NaturalSort
===========

Sort a list of strings containing numbers in a natural manner.

Sort functions will not [generally] sort strings containing
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

### `NaturalSort.sort(list, options \\ [])`

Sorts a list of strings. This works by leveraging Elixir's
`Enum.sort_by/3` function (which takes as the second argument
a mapping function). The mapping operation converts each string
into a list of strings and integers. Once in this form, applying
the sort function results in a correctly sorted list.

### `NaturalSort.sort_by(list, mapping_fun, options \\ [])`

Works as `sort/2`, but accepts a custom mapping function which
allows one to sort lists of arbitrary data structures such as maps
or structs. The mapping function accepts one element and must
return a string. See the Examples section below.

#### Options

* `:direction` may have a value of `:asc` or `:desc`, and
  defaults to `:asc`.
* `:case_sensitive` may be `true` or `false`, and defaults
  to `false`.


#### Examples

      iex> NaturalSort.sort(["x2-y7", "x8-y8", "x2-y08", "x2-g8" ])
      ["x2-g8", "x2-y7", "x2-y08", "x8-y8" ]

      iex> NaturalSort.sort(["a5", "a400", "a1"], direction: :desc)
      ["a400", "a5", "a1"]

      iex> NaturalSort.sort(["foo03.z", "foo45.D", "foo06.a", "foo06.A", "foo"], case_sensitive: :true)
      ["foo", "foo03.z", "foo06.A", "foo06.a", "foo45.D"]

      iex> NaturalSort.sort(["foo03.z", "foo45.D", "foo06.a", "foo06.A", "foo"], [case_sensitive: :true, direction: :desc])
      ["foo45.D", "foo06.a", "foo06.A", "foo03.z", "foo"]

      iex> NaturalSort.sort_by([%{sortable: "1-20"}, %{sortable: "1-2"}, %{sortable: "10-20"}, %{sortable: "1-02"}], fn x -> x.sortable end)
      [%{sortable: "1-2"}, %{sortable: "1-02"}, %{sortable: "1-20"}, %{sortable: "10-20"}]

## Prior art:

[VersionEye's naturalsorter gem](https://github.com/versioneye/naturalsorter)
was the inspiration, with that being based on
[Martin Pool's natural sorting algorithm](http://sourcefrog.net/projects/natsort/), and making direct use of the Ruby implementation of the original
C version.

Elixir's [Version](https://github.com/elixir-lang/elixir/blob/v1.0.4/lib/elixir/lib/version.ex#L1) module does a similar thing.

## Todo/Review

- REVIEW: Benchmark further.
- ENHANCEMENT: Add options: choice to use unicode, choice to strip whitespace from result.
- ENHANCEMENT: Stream rather than map - this was designed to aid me in organising vast amounts of files by name; mapping over large lists seems inefficient.
