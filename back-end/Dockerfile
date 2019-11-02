FROM elixir:1.8.2-otp-22

RUN apt-get update
RUN apt-get install -y inotify-tools postgresql-client curl apt-transport-https libpq-dev

COPY . /app
WORKDIR /app

RUN mix local.hex --force
RUN mix archive.install hex phx_new 1.4.10 --force

ENTRYPOINT ["./entrypoint.sh"]
