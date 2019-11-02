defmodule JsonApi.Repo.Migrations.AddUniqueConstraint do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
    create unique_index(:roles, [:name])
    create unique_index(:teams, [:name])

  end
end
