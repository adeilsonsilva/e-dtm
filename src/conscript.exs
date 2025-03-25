Code.require_file("/home/captain.exs") # TODO: learn how to compile stuff with mix
# require Captain

IO.puts("Hello from #{inspect(Node.self)}.")


Captain.enlist(Node.self)

Process.sleep(10000)

Captain.get()
