FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app

RUN mkdir assets

# COPY assets/package.json assets
# COPY assets/package-lock.json assets

COPY . .

# RUN mix deps.get

# RUN mix ecto.create

# RUN mix ecto.migrate

# CMD mix phx.server

RUN mix local.hex --force && mix local.rebar --force && mix do deps.get, compile


# CMD mix deps.get && cd assets && npm install && cd .. && mix ecto.create && mix ecto.migrate && mix phx.server

CMD mix ecto.create && mix ecto.migrate && mix phx.server