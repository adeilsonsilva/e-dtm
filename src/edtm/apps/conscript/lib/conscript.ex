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

  @captain_server {:global, Captain}

  def start_link(opts \\ []) do
    Agent.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # TODO: check why we need hello/1 (if we remove value parameter it crashes)
  def hello(value) do
    IO.puts("Starting Conscript at #{inspect(Node.self)}.")


    # TODo: check why even using libcluster we still need to sleep for the connection to work
    Process.sleep(1000)
    pid = GenServer.whereis(@captain_server)
    pid |> IO.inspect(label: "Captain running @")

    GenServer.call(@captain_server, {:enlist, Node.self})
    Process.sleep(1000)
    # list = Captain.get()
    GenServer.call(@captain_server, :get) |> IO.inspect(label: "nodes: ")

  end

    list = Captain.get()
    IO.puts("list: #{inspect(list)}")

  end
end
