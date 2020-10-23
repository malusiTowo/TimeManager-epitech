# FROM elixir:latest

# RUN apt-get update && \
#     apt-get install -y postgresql-client && \
#     apt-get install -y inotify-tools && \
#     apt-get install -y nodejs && \
#     curl -L https://npmjs.org/install.sh | sh && \
#     mix local.hex --force && \
#     mix archive.install hex phx_new 1.5.3 --force && \
#     mix local.rebar --force

# ENV APP_HOME /app

# RUN mkdir $APP_HOME

# WORKDIR $APP_HOME

# COPY . .

# RUN mix do compile

# RUN mix deps.get

# RUN mix ecto.create

# RUN mix ecto.migrate



# CMD ["mix", "phx.server"]

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

CMD mix deps.get && cd assets && npm install && cd .. && mix ecto.create && mix ecto.migrate && mix phx.server