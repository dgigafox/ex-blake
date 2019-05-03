defmodule Mix.Tasks.Compile.Blake256 do
  def run(_args) do
    {result, _errcode} = System.cmd("make", [])
    IO.binwrite(result)
  end
end

defmodule ExBlake.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_blake,
      compilers: [:blake256] ++ Mix.compilers,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    []
  end
end
