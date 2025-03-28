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

  import Captain

  def start_link(opts \\ []) do
    Agent.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def hello(value) do
    IO.puts("Hello from #{inspect(Node.self)}.")

    Captain.enlist(Node.self)

    Process.sleep(5000)

    list = Captain.get()
    IO.puts("list: #{inspect(list)}")

  end
end
