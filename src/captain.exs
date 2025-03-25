defmodule Captain do
    use GenServer

    ###########################
    ### Public (client) API ###
    ###########################

    # Start with an empty list of conscripts by default
    def start(conscripts \\ []) do
        GenServer.start_link(__MODULE__, conscripts, name: {:global, __MODULE__})
    end

    def get() do
        GenServer.call(__MODULE__, :get)
    end

    def enlist(value) do
        # Synchronous
        GenServer.call(__MODULE__, {:enlist, value})
    end

    def discharge() do
        # Asynchronous
        GenServer.cast(__MODULE__, :discharge)
    end


    ############################
    ### Private (server) API ###
    ############################

    def init(conscripts) do
        IO.puts("Hello from #{inspect(Node.self)}.")
        {:ok, conscripts}
    end


    def handle_call(:get, _from, conscripts), do: {:reply, conscripts, conscripts}


    def handle_cast({:enlist, value}, conscripts) do
        {:noreply, conscripts ++ [value]}
    end

    def handle_call(:discharge, _from, [value | state]) do
        {:reply, value, state}
    end

end


children = [
    # The Captain is a child started via Captain.start_link(0)
    %{
        id: Captain,
        start: {Captain, :start, []}
    }
]

# Now we start the supervisor with the children and a strategy
{:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)

# After started, we can query the supervisor for information
Supervisor.count_children(pid)
#=> %{active: 1, specs: 1, supervisors: 0, workers: 1}

# TODO: check how to keep process alive
Process.sleep(30000)
