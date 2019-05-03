defmodule ExBlake do
  @moduledoc """
  Implementation of Blake-256, predecessor of Blake2 via NIF
  """
  @on_load :load_nifs

  def load_nifs do
    :erlang.load_nif('./priv/blake256', 0)
  end

  def hash_nif(msg)
  def hash_nif(_msg), do: exit(:nif_library_not_found)

  def hash(payload) when is_binary(payload) do
    hash_nif(payload)
    |> :binary.list_to_bin()
  end
end
