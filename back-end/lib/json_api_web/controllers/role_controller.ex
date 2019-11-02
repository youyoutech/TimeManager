defmodule JsonApiWeb.RoleController do
  use JsonApiWeb, :controller

  alias JsonApi.Models
  alias JsonApi.Models.Role

  action_fallback JsonApiWeb.FallbackController

  def index(conn, _params) do
    roles = Models.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def create(conn, %{"role" => role_params}) do
    with {:ok, %Role{} = role} <- Models.create_role(role_params) do
      conn
      |> put_status(:created)
      |> render("show.json", role: role)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Models.get_role!(id)
    render(conn, "show.json", role: role)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Models.get_role!(id)

    with {:ok, %Role{} = role} <- Models.update_role(role, role_params) do
      render(conn, "show.json", role: role)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Models.get_role!(id)

    with {:ok, %Role{}} <- Models.delete_role(role) do
      send_resp(conn, :no_content, "")
    end
  end
end
