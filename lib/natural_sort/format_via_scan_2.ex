defmodule NaturalSort.FormatViaScan2 do

  def format_item(item, case_sensitive?) when is_number(item), do: item
  def format_item(item, case_sensitive?) do
    item
    |> format_case(case_sensitive?)
    # NOTE uses [relatively slow] unicode flag in regex.
    |> string_scan(~r/(\p{Nd}+)|(\p{L}+)/u)
    |> List.flatten
    |> Enum.map(fn item -> convert_integers(item) end)
  end

  defp format_case(item, case_sensitive?) do
    case case_sensitive? do
      true  -> item
      false -> String.downcase(item)
    end
  end

  defp convert_integers(string) do
    # NOTE uses [relatively slow] unicode flag in regex.
    case Regex.match?(~r/\p{Nd}+/u, string) do
      true  -> String.to_integer(string)
      false -> string
    end
  end

  defp string_scan(string, regex), do: Regex.scan(regex, string, capture: :all_but_first)
end
