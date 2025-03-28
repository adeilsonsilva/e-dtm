defmodule Conscript do
  @moduledoc """
  Documentation for `Conscript`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Conscript.hello()
      :world

  """

  use Agent

  def start_link(opts \\ []) do
    Agent.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # TODO: check why we need hello/1 (if we remove value parameter it crashes)
  def hello(value) do
    IO.puts("Starting Conscript at #{inspect(Node.self)}.")


    # TODO: the connection needs to be done prior to starting the script
    # currently it spawns a Captain in the same VM and only after the Node.connect
    # it uses the instance in the remote node
    captain = "#{System.get_env("RELEASE_NODE")}@#{System.get_env("CAPTAIN_HOSTNAME")}"
    IO.puts("Connecting to #{captain}.")
    Node.connect(String.to_atom(captain)) |> IO.inspect(label: "Connected to #{captain}")
    Process.sleep(5000)

    Captain.enlist(Node.self)

    Process.sleep(5000)

    list = Captain.get()
    IO.puts("list: #{inspect(list)}")

  end
end
