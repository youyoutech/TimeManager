defmodule JsonApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add(:password_hash, :string, null: false)

      add :role_id, references(:roles)
      add :team_id, references(:teams)


      timestamps()
    end

  end
end
