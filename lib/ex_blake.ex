defmodule ExBlake do
  @moduledoc """
  Implementation of Blake-256, predecessor of Blake2 via NIF
  """
  @on_load {:init, 0}

  app = Mix.Project.config[:app]

  def init do
    path = :filename.join(:code.priv_dir(unquote(app)), 'blake256')
    :ok = :erlang.load_nif(path, 0)
  end

  def hash_nif(msg)
  def hash_nif(_msg), do: exit(:nif_library_not_found)

  def hash(payload) when is_binary(payload) do
    hash_nif(payload)
    |> :binary.list_to_bin()
  end
end
