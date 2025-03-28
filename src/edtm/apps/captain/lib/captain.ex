defmodule Captain do
  @moduledoc """
  Documentation for `Captain`.
  """

  @doc """
  Hello world.

  ## Examples

  """
  use GenServer

  ###########################
  ### Public (client) API ###
  ###########################

  # Start with an empty list of conscripts by default
  def start_link(conscripts \\ []) do
    GenServer.start_link(__MODULE__, conscripts, name: {:global, __MODULE__})
  end

  def get() do
    GenServer.call({:global, __MODULE__}, :get)
  end

  def enlist(value) do
    # Synchronous
    GenServer.call({:global, __MODULE__}, {:enlist, value})
  end

  def discharge() do
    # Asynchronous
    GenServer.cast({:global, __MODULE__}, :discharge)
  end


  ############################
  ### Private (server) API ###
  ############################

  def init(conscripts) do
    IO.puts("Hello from #{inspect(Node.self)}.")
    {:ok, conscripts}
  end


  def handle_call(:get, _from, conscripts) do
    IO.puts("Returning state.")
    {:reply, conscripts, conscripts}
  end

  def handle_call({:enlist, value}, _from, conscripts) do
    IO.puts("Enlisting #{value}.")
    {:reply, :ok, conscripts ++ [value]}
  end

  def handle_cast(:discharge, _from, [value | state]) do
    IO.puts("Discharging #{value}.")
    {:noreply, value, state}
  end
end
