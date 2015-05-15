defmodule NaturalSort.FormatViaScan do

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

  defp convert_integers(string) do
    case Regex.match?(~r/\p{Nd}+/u, string) do
      true  -> String.to_integer(string)
      false -> string
    end
  end


  defp isolate_common_groups(string) do
    string
    |> string_scan(~r/(\p{Nd}+)|(\p{L}+)|(\p{P}+)/u)
    |> List.flatten
    |> Enum.filter(fn item -> item != "" end)
  end

  defp string_scan(string, regex), do: Regex.scan(regex, string)
end
