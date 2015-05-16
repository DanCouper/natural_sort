defmodule NaturalSort.ScanTest do
  use ExUnit.Case

  test "should return an empty list if handed an empty list" do
    assert NaturalSort.sort_by_scan_2([]) == []
  end

  test "should sort integers" do
    unsorted = [9,6,3,4,2,8,1,7,0,5]
    sorted   = [0,1,2,3,4,5,6,7,8,9]
    assert NaturalSort.sort_by_scan_2(unsorted) == sorted
  end

  test "should sort basic strings as expected" do
    unsorted = ["jane", "fred"]
    sorted   = ["fred", "jane"]
    assert NaturalSort.sort_by_scan_2(unsorted) == sorted
  end

  test "should sort basic case" do
    unsorted = ["foo2", "foo3", "foo1"]
    sorted   = ["foo1", "foo2", "foo3"]
    assert NaturalSort.sort_by_scan_2(unsorted) == sorted
  end

  test "should ignore leading/trailing whitespace" do
    unsorted = ["foo2    ", "foo3", "    foo1"]
    sorted   = ["    foo1", "foo2    ", "foo3"]
    assert NaturalSort.sort_by_scan_2(unsorted) == sorted
  end

  test "should understand trailing zeroes" do
    unsorted = ["foo200", "foo50", "foo10"]
    sorted   = ["foo10", "foo50", "foo200"]
    assert NaturalSort.sort_by_scan_2(unsorted) == sorted
  end

  test "should sort with leading zeroes" do
    unsorted = ["foo002", "foo03", "foo1"]
    sorted   = ["foo1", "foo002", "foo03"]
    assert NaturalSort.sort_by_scan_2(unsorted) == sorted
  end

  test "should sort strings of numbers" do
    unsorted = ["1-20", "1-2", "10-20", "1-02"]
    sorted   = ["1-2", "1-02", "1-20", "10-20"]
    assert NaturalSort.sort_by_scan_2(unsorted) == sorted
  end

  test "should sort values inside string first, then sort by letter" do
    unsorted = ["a10",  "a05c",  "a1",  "a",  "a2",  "a1a",  "a0",  "a1b",  "a20"]
    sorted   = ["a", "a0", "a1", "a1a", "a1b", "a2", "a05c", "a10", "a20"]
    assert NaturalSort.sort_by_scan_2(unsorted) == sorted
  end

  test "should sort strings with several number parts" do
    unsorted = ["x2-y7", "x8-y8", "x2-y08", "x2-g8" ]
    sorted   = ["x2-g8", "x2-y7", "x2-y08", "x8-y8" ]
    assert NaturalSort.sort_by_scan_2(unsorted) == sorted
  end

  test "should sort long lists of strings" do
    unsorted = ["pic 5 something", "pic01", "pic 5", "pic02a", "pic3", "pic 5 ", "pic100", "pic02000", "pic2", "pic 4 else", "pic4", "pic02", "pic05", "pic 6", "pic121", "pic100a", "pic   7", "pic120"]
    sorted   = ["pic01", "pic2", "pic02", "pic02a", "pic3", "pic4", "pic 4 else", "pic 5", "pic 5 ", "pic05", "pic 5 something", "pic 6", "pic   7", "pic100", "pic100a", "pic120", "pic121", "pic02000"]
    assert NaturalSort.sort_by_scan_2(unsorted) == sorted
  end

  # case_sensitive flag set to true:
  # ################################

  test "should take case into account if flag is turned on" do
    unsorted = ["foo03.z", "foo45.D", "foo06.a", "foo06.A", "foo"]
    sorted   = ["foo", "foo03.z", "foo06.A", "foo06.a", "foo45.D"]
    assert NaturalSort.sort_by_scan_2(unsorted, true) == sorted
  end

  #######################################

  test "should pass further sorting tests 1 from https://github.com/versioneye/naturalsorter" do
    assert NaturalSort.sort_by_scan_2(["c", "b", "a"]) == ["a", "b", "c"]
  end

  test "should pass further sorting tests 2 from https://github.com/versioneye/naturalsorter" do
    assert NaturalSort.sort_by_scan_2(["2.2.1-b03", "2.2"]) == ["2.2", "2.2.1-b03"]
  end

  test "should pass further sorting tests 3 from https://github.com/versioneye/naturalsorter" do
    assert NaturalSort.sort_by_scan_2(["a400", "a5", "a1"]) == ["a1", "a5", "a400"]
  end

  test "should pass further sorting tests 4 from https://github.com/versioneye/naturalsorter" do
    assert NaturalSort.sort_by_scan_2(["1.5.2", "1.4.4", "1.5.2-patch"]) == ["1.4.4", "1.5.2", "1.5.2-patch"]
  end

  test "should pass further sorting tests 6 from https://github.com/versioneye/naturalsorter" do
    assert NaturalSort.sort_by_scan_2(["a400", "a5", "a1"]) == ["a1", "a5", "a400"]
  end

  test "should pass further sorting tests 7 from https://github.com/versioneye/naturalsorter" do
    assert NaturalSort.sort_by_scan_2(["1.5.2-patch", "1.5.2", "1.4.4"]) == ["1.4.4", "1.5.2", "1.5.2-patch"]
  end
end
