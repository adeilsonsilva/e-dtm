defmodule Edtm.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        server: [
          include_executables_for: [:unix],
          applications: [captain: :permanent],
        ],
        client: [
          include_executables_for: [:unix],
          applications: [conscript: :permanent]
        ],
      ]
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:libcluster, "~> 3.5"},
      {:yaml_elixir, "~> 2.11"},
    ]
  end
end
