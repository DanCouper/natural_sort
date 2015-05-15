defmodule RegexFormatterBench do
  use Benchfella

  setup_all do
    depth = :erlang.system_flag(:backtrace_depth, 100)
    {:ok, depth}
  end

  teardown_all depth do
    :erlang.system_flag(:backtrace_depth, depth)
  end

  bench "Original format function recursing through string" do
    NaturalSort.FormatViaRecursion.format_item("foo123foo456_#05", false)
  end

  bench "New format function using scan" do
    NaturalSort.FormatViaScan.format_item("foo123foo456_#05", false)
  end
end
