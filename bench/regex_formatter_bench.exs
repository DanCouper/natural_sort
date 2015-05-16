defmodule RegexFormatterBench do
  use Benchfella

  bench "Original format function recursing through string" do
    NaturalSort.FormatViaRecursion.format_item("foo123foo456_#05", false)
  end

  bench "New format function using scan" do
    NaturalSort.FormatViaScan.format_item("foo123foo456_#05", false)
  end

  bench "Optimised New format function using scan" do
    NaturalSort.FormatViaScan2.format_item("foo123foo456_#05", false)
  end
end
