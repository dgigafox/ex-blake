defmodule Mix.Tasks.Compile.Blake256 do
  def run(_args) do
    cp = Mix.Project.compile_path()
    priv_path = Path.join([cp, "..", "priv"])
    File.mkdir_p(priv_path)
    File.mkdir_p("priv")
    if Mix.shell.cmd("PRIV_PATH=#{priv_path} make all") != 0 do
      raise Mix.Error, message: "could not run `make all`."
    end
    File.copy(Path.join([priv_path, "blake256.so"]), "priv")
    :ok
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
