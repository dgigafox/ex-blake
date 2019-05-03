defmodule ExBlakeTest do
  @moduledoc """
  This test ensures that the hashing function results to the correct output/s based on the
  test vectors described on the Blake official documentation https://www.131002.net/blake/blake.pdf.
  """
  use ExUnit.Case
  doctest ExBlake

  @expected_8_bit_zeros "0CE8D4EF4DD7CD8D62DFDED9D4EDB0A774AE6A41929A74DA23109E8F11139C87"
  @expected_576_bit_zeros "D419BAD32D504FB7D44D460C42C5593FE544FA4C135DEC31E21BD9ABDCC22D41"

  describe "hash/1" do
    test "can return correct output of 8-bit message 00000000" do
      result = ExBlake.hash(<<0::size(8)>>) |> Base.encode16(case: :lower)
      assert result == String.downcase(@expected_8_bit_zeros)
    end

    test "can return correct output of 576-bit message 0000...0000" do
      result = ExBlake.hash(<<0::size(576)>>) |> Base.encode16(case: :lower)
      assert result == String.downcase(@expected_576_bit_zeros)
    end
  end
end
