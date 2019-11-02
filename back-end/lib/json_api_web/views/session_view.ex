defmodule JsonApiWeb.SessionView do
  use JsonApiWeb, :view

  def render("show.json", %{users: users, jwt: jwt}) do
    %{
      data: render_one(users, JsonApiWeb.UsersView, "users.json"),
      meta: %{token: jwt}
    }
  end

  def render("delete.json", _) do
    %{ok: true}
  end

  def render("error.json", %{error: error}) do
    %{errors: %{error: error}}
  end
end
