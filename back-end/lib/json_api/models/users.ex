defmodule JsonApi.Models.Users do
  use Ecto.Schema
  import Ecto.Changeset

  alias JsonApi.Models.Users

  @derive {Jason.Encoder, only: [:id, :email, :username, :role_id, :team_id]}
  schema "users" do
    field(:email, :string)
    field(:username, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)

    belongs_to :role, JsonApi.Models.Role
    belongs_to :team, JsonApi.Models.Team

    has_many :workingtimes, JsonApi.Models.Workingtime

    timestamps()
  end

  def changeset(%Users{} = users, attrs) do
    users
    |> cast(attrs, [:username, :email, :role_id, :team_id])
    |> validate_required([:username, :email, :role_id])
    |> validate_length(:username, min: 2, max: 255)
    |> validate_length(:email, min: 5, max: 255)
    |> unique_constraint(:email, name: :users_email_username_index)
    |> unique_constraint(:username, name: :users_username_index)
    |> validate_format(:email, ~r/@/)
  end

  def registration_changeset(%Users{} = users, attrs) do
    users
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8, max: 100)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Argon2.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
