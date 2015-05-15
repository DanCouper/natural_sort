defmodule NaturalSort do
  @moduledoc """
  Sort a list naturally.

  Sort functions will not, generally, sort strings containing
  numbers the same way a human would.

  Given a list:

      ["a10",  "a05c",  "a1",  "a",  "a2",  "a1a",  "a0",  "a1b",  "a20"]

  Applying standard sort will produce

      ["a", "a0", "a05c", "a1", "a10", "a1a", "a1b", "a2", "a20"]

  But applying a natural sort will give:

      ["a", "a0", "a1", "a1a", "a1b", "a2", "a05c", "a10", "a20"]

  ## Prior art:

  [VersionEye's naturalsorter gem](https://github.com/versioneye/naturalsorter)
  was the inspiration, with that being based on
  [Martin Pool's natural sorting algorithm](http://sourcefrog.net/projects/natsort/),
  making direct use of the Ruby implementation of the original
  C version.
  """

  alias NaturalSort.FormatViaRecursion
  alias NaturalSort.FormatViaScan


  @doc """
  Sorts a list of strings. This works by leveraging Elixir's
  `Enum.sort_by/3` function, which takes as the second argument
  a mapping function. Each string is converted into a list
  of strings and integers. Once in this form, applying the
  sort function results in a correctly sorted list.

  ## Examples

    iex> NaturalSort.sort(["x2-y7", "x8-y8", "x2-y08", "x2-g8" ])
    ["x2-g8", "x2-y7", "x2-y08", "x8-y8" ]

    NaturalSort.sort(["foo03.z", "foo45.D", "foo06.a", "foo06.A", "foo"],, true)
    ["foo", "foo03.z", "foo06.A", "foo06.a", "foo45.D"]
  """

  def sort([]), do: []
  def sort(list, case_sensitive? \\ false) do
    Enum.sort_by(list, fn x -> FormatViaRecursion.format_item(x, case_sensitive?) end)
  end


  @doc """
  An alias for `NaturalSort.sort`, which sorts ascending
  by default.

  ## Examples

    iex> NaturalSort.sort_asc(["x2-y7", "x8-y8", "x2-y08", "x2-g8" ])
    ["x2-g8", "x2-y7", "x2-y08", "x8-y8"]
  """

  def sort_asc(list, case_sensitive? \\ false) do
    sort(list, case_sensitive?)
  end

  @doc """
  Sorts a list in descending order, rather than ascending
  as is the default for `NaturalSort.sort`.

  ## Examples

    iex> NaturalSort.sort_desc(["a5", "a400", "a1"])
    ["a400", "a5", "a1"]
  """

  def sort_desc(list, case_sensitive? \\ false) do
    Enum.sort_by(list, fn x -> FormatViaRecursion.format_item(x, case_sensitive?) end, &>=/2)
  end

  ##################################################



  #############


end
