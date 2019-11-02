defmodule JsonApi.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do

      add :users_id, references(:users, on_delete: :delete_all)
      add :time, :naive_datetime
      add :status, :boolean, default: false
      timestamps()
    end

  end
end
