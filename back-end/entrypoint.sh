#!/bin/bash

if [ ! -f /app/.env ]; then
    >&2 echo ".env file not found. Stopping container."
    docker stop phoenix
else
  ./.env
fi

until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$PGHOST" -U "$POSTGRES_USER" "$POSTGRES_DB" -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

mix deps.get

mix ecto.create
mix ecto.migrate

mix run /app/priv/repo/seeds/users_seeds.exs
mix run /app/priv/repo/seeds/clock_seeds.exs
mix phx.server
