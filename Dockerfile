FROM elixir:1.13.1

ENV MIX_TAILWIND_VERSION 3.0.8
ENV MIX_TAILWIND_PATH /usr/local/bin

RUN set -xe && \
  ARCH=`uname -m` && \
  if [ "$ARCH" == "aarch64" ]; then \
  echo "aarch64" && \
  wget -O /usr/local/bin/tailwindcss https://github.com/tailwindlabs/tailwindcss/releases/download/v3.0.8/tailwindcss-linux-arm64; \
  else \
  echo "x64" && \
  wget -O /usr/local/bin/tailwindcss https://github.com/tailwindlabs/tailwindcss/releases/download/v3.0.8/tailwindcss-linux-x64; \
  fi \
  && chmod a+x /usr/local/bin/tailwindcss

RUN set -xe \
  && apt-get update \
  && apt-get install -y --no-install-recommends inotify-tools \
  && mix local.hex --force \
  && mix local.rebar --force \
  && mix archive.install hex phx_new --force 

RUN mkdir /app
WORKDIR /app

RUN mix local.hex --force && mix local.rebar --force && mix archive.install hex phx_new --force

COPY mix.exs .
COPY mix.lock .

CMD mix deps.get && mix phx.server
