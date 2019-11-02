defmodule JsonApiWeb.UsersView do
  use JsonApiWeb, :view
  alias JsonApiWeb.UsersView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UsersView, "users.json")}
  end

  def render("indexclocks.json", %{users: users}) do
    %{data: render_many(users, UsersView, "usersclocks.json")}
  end

  def render("show.json", %{users: users}) do
    %{data: render_one(users, UsersView, "users.json")}
  end

  def render("teammates.json", %{users: users}) do
    %{data: render_many(users, UsersView, "mates.json")}
  end

  def render("users.json", %{users: users}) do
    %{id: users.id,
      username: users.username,
      email: users.email,
      role_id: users.role_id,
      team_id: users.team_id}
  end

  def render("usersclocks.json", %{users: users}) do
    %{id: users.id,
      username: users.username,
      email: users.email,
      role_id: users.role_id,
      team_id: users.team_id,
      workingtime: users.workingtimes}
  end

  def render("mates.json", %{users: users}) do
    %{id: users.id,
      username: users.username,
      email: users.email,
      role_id: users.role_id}
  end

  def render("number.json", %{number: number}) do
    %{number: number}
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end
end
