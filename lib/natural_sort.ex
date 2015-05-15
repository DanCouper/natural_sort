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
    Enum.sort_by(list, fn x -> format_item(x, case_sensitive?) end)
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
    Enum.sort_by(list, fn x -> format_item(x, case_sensitive?) end, &>=/2)
  end

  ##################################################

  defp format_item(item, case_sensitive?) when is_number(item), do: item
  defp format_item(item, case_sensitive?) do
    item
    |> String.replace(~r/\p{Z}/u, "")
    |> format_case(case_sensitive?)
    |> isolate_common_groups
    |> remove_puctuation_groups
    |> Enum.map(fn item -> convert_integers(item) end)
  end

  defp format_case(item, case_sensitive?) do
    case case_sensitive? do
      true  -> item
      false -> String.downcase(item)
    end
  end

  defp remove_puctuation_groups(list) do
    Enum.filter(list, fn item -> Regex.match?(~r/\p{P}+/u, item) != true end)
  end

  # REVIEW should integer groups with leading zeroes
  # be converted to integers or sorted alphabetically?
  # This is an extremely minor implementation detail,
  # but (for example) what order should
  # ["005", "00005", "5"] be returned in?
  # Possible conversion function commented below this one.
  defp convert_integers(string) do
    case Regex.match?(~r/\p{Nd}+/u, string) do
      true  -> String.to_integer(string)
      false -> string
    end
  end

  # defp convert_integers(string) do
  #   cond do
  #     Regex.match?(~r/\A0/, string)      -> string
  #     Regex.match?(~r/\p{Nd}+/u, string) -> String.to_integer(string)
  #     true                               -> string
  #   end
  # end


  defp isolate_common_groups(string) do
    list = isolate_initial_group(string)
    recursively_isolate_groups(list)
  end

  defp isolate_initial_group(string) do
    Regex.run(~r/(\p{Nd}+|\p{L}+|\p{P}+)(.+|\z)/u, string, capture: :all_but_first)
    # NOTE the regex may return zero-length strings
    # depending upon context: the filter removes them
    |> Enum.filter(fn item -> item != "" end)
  end


  defp recursively_isolate_groups(list) when length(list) == 1, do: list
  defp recursively_isolate_groups(list) do
    [head|tail] = list |> Enum.reverse

    if isolate_initial_group(head) == [head] do
      list
    else
      [isolate_initial_group(head)|tail]
      |> Enum.reverse
      |> List.flatten
      |> recursively_isolate_groups
    end
  end
end
