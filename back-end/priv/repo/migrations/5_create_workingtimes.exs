defmodule JsonApi.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do

      add :users_id, references(:users, on_delete: :delete_all)
      add :start_day, :naive_datetime
      add :end_day, :naive_datetime

    end

  end
end
