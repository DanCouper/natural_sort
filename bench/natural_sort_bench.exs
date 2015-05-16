defmodule NaturalSortBench do
  use Benchfella

  Faker.start()


  @list ["pic 5 something", "pic01", "pic 5", "pic02a", "pic3", "pic 5 ", "pic100", "pic02000", "pic2", "pic 4 else", "pic4", "pic02", "pic05", "pic 6", "pic121", "pic100a", "pic   7", "pic120"]

  bench "natural sort using explicit recursion to break up the strings", [list: gen_list()] do
    NaturalSort.sort(list)
  end

  bench "natural sort using Regex.scan to break up the strings", [list: gen_list()] do
    NaturalSort.sort_by_scan(list)
  end

  bench "second natural sort using Regex.scan to break up the strings", [list: gen_list()] do
    NaturalSort.sort_by_scan_2(list)
  end

  defp gen_list do
    1..500
    |> Enum.map(fn item -> Faker.Internet.mac_address() end)
  end

end


