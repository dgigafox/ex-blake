defmodule ExBlake.Helper.Python do
  def python_instance(path) when is_list(path) do
    {:ok, pid} = :python.start([{:python_path, to_charlist(path)}])
    pid
  end

  def python_instance(_path) do
    {:ok, pid} = :python.start()
    pid
  end

  def call(pid, module, function, arguments \\ []) do
    :python.call(pid, module, function, arguments)
  end
end
