defmodule ExBlake do
  @moduledoc """
  Implementation of Blake-256, predecessor of Blake2.
  """
  alias ExBlake.Helper.Python

  def hash(payload) when is_binary(payload) do
    call_python(:blake256, :blake_hash, [payload])
  end

  defp default_instance() do
    path = [:code.priv_dir(:ex_blake), "python"] |> Path.join()
    Python.python_instance(to_charlist(path))
  end

  defp call_python(module, function, args) do
    Python.call(default_instance(), module, function, args)
  end
end
