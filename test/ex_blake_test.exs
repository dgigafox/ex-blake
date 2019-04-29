defmodule ExBlakeTest do
  use ExUnit.Case
  doctest ExBlake

  @sample_binary <<7, 63, 226, 128, 203, 110, 102, 185, 102, 121, 174, 194, 136, 177, 251, 219,
                   212, 219, 8, 7, 122, 27>>

  describe "hash/1" do
    test "can return a Blake-256 hashed binary" do
      assert <<_hashed::size(256)>> = ExBlake.hash(@sample_binary)
    end
  end
end
