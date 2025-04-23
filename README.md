# e-dtm
Distributed task management with Elixir (Erlang).


## Running

```
docker compose up
```

## Running (without compose)

```
docker run -i -t --user "${UUID}:${UGID}" -v ./src:/home elixir:latest /bin/bash
```

### Compiling

```
docker run -i -t --user "${UUID}:${UGID}" -v ./src:/home --workdir /home/edtm elixir:latest /bin/bash -c "mix release server && mix release client"
```
