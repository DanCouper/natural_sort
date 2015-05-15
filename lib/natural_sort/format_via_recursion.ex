defmodule NaturalSort.FormatViaRecursion do

  def format_item(item, case_sensitive?) when is_number(item), do: item
  def format_item(item, case_sensitive?) do
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
