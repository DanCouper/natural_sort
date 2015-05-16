defmodule NaturalSort.Mixfile do
  use Mix.Project

  def project do
    [app: :natural_sort,
     version: "0.2.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     description: description,
     package: package
   ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end

  defp description do
    """
    Sort a list of strings containing numbers in a natural manner.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      contributors: ["Daniel Couper"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/DanCouper/natural_sort"}
    ]
  end
end
