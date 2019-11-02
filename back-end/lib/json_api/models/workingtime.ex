defmodule JsonApi.Models.Workingtime do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :start_day, :end_day]}
  schema "workingtimes" do
      field :start_day, :naive_datetime
      field :end_day, :naive_datetime

      belongs_to :users, JsonApi.Models.Users
  end

  @doc false
  def changeset(workingtime, attrs) do
    workingtime
    |> cast(attrs, [:start_day, :end_day, :users_id])
    |> validate_required([:start_day, :end_day, :users_id])
  end
end
