defmodule NaturalSort.FormatViaScan2 do
  # Order of operations:
  # 1. Downcase if flag set
  # 2. Break string into groups of num/letters in a list
  # 3. Convert number strings to integers

  def format_item(item, case_sensitive?) when is_number(item), do: item
  def format_item(item, case_sensitive?) do
    item
    |> format_case(case_sensitive?)
    |> string_scan(~r/([0-9]+)|([a-zA-Z]+)/)
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
    case Regex.match?(~r/[0-9]+/, string) do
      true  -> String.to_integer(string)
      false -> string
    end
  end

  defp string_scan(string, regex), do: Regex.scan(regex, string)
end
