# syntax=docker/dockerfile:1

FROM elixir:1.17-otp-27 AS build

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends build-essential git ca-certificates \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
ENV MIX_ENV=prod

RUN mix local.hex --force && mix local.rebar --force

COPY mix.exs mix.lock ./
COPY config/config.exs config/prod.exs config/
RUN mix deps.get --only prod
RUN mix deps.compile

COPY priv priv
COPY lib lib
COPY assets assets
COPY config/runtime.exs config/

RUN mix assets.setup
RUN mix compile
RUN mix assets.deploy
RUN mix release

FROM debian:bookworm-slim AS runtime

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends libstdc++6 openssl libncurses6 ca-certificates locales \
  && sed -i '/en_US.UTF-8/s/^# //' /etc/locale.gen && locale-gen \
  && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

WORKDIR /app
COPY --from=build /app/_build/prod/rel/oil_moguls ./

RUN useradd --create-home --shell /bin/bash appuser && chown -R appuser:appuser /app
USER appuser

ENV PHX_SERVER=true
ENV PORT=8080
EXPOSE 8080

CMD ["/app/bin/oil_moguls", "start"]
