defmodule JsonApi.Repo.Migrations.InsertTeams do
  use Ecto.Migration

  def change do
    execute"INSERT INTO roles (name) VALUES ('user')"
    execute"INSERT INTO roles (name) VALUES ('manager')"
    execute"INSERT INTO roles (name) VALUES ('admin')"

  end
end

