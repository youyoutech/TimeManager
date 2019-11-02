defmodule JsonApi.Models.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :time, :status]}
  schema "clocks" do
      field :time, :naive_datetime
      field :status, :boolean

      belongs_to :users, JsonApi.Models.Users
    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :users_id])
    |> validate_required([:time, :status, :users_id])
  end
end
