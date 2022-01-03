FROM elixir:1.13.1

ENV MIX_TAILWIND_VERSION 3.0.8

RUN set -xe \
  && apt-get update \
  && apt-get install -y --no-install-recommends inotify-tools \
  && mix local.hex --force \
  && mix local.rebar --force \
  && mix archive.install hex phx_new --force 

RUN mkdir /app
WORKDIR /app

COPY mix.exs .
COPY mix.lock .

CMD mix deps.get && mix phx.server
