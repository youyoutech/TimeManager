defmodule JsonApi.Repo.Migrations.CreateATeam do
  use Ecto.Migration

  def change do
    execute"INSERT INTO teams (name) VALUES ('general')"
    execute"INSERT INTO teams (name) VALUES ('team2')"
  end
end
