defmodule JsonApiWeb.UsersController do
  use JsonApiWeb, :controller

  alias JsonApi.Models
  alias JsonApi.Models.Users
  alias JsonApi.Auth.Guardian
  action_fallback(JsonApiWeb.FallbackController)

  #[POST] /api/users
  #?username : String
  #?email : String

  def create(conn, params) do
    with {:ok, %Users{} = users} <- Models.create_user(params) do
      new_conn = Guardian.Plug.sign_in(conn, users)
      jwt = Guardian.Plug.current_token(new_conn)

      new_conn
      |> put_status(:created)
      |> render(JsonApiWeb.SessionView, "show.json", users: users, jwt: jwt)
    end
  end

  def list_users_from_manager_by_team(conn, %{"teamid" => teamid}) do
    users = Models.list_users_from_manager(teamid)
    render(conn, "index.json", users: users)
  end

  def get_team_mates(conn, %{"id" => id}) do
    team_id = Models.get_user(id).team_id
    mates = Models.get_team_mates(team_id)
    render(conn, "teammates.json", users: mates)
  end

  def list_users_from_admin_by_team(conn, %{"teamid" => teamid}) do
    users = Models.list_users_from_admin_by_team(teamid)
    render(conn, "index.json", users: users)
  end

  def list_all_users_from_admin(conn, _params) do
    users = Models.list_all_users_from_admin
    render(conn, "index.json", users: users)
  end

  def list_all_users_from_admin_with_clocks(conn, _params) do
    users = Models.list_all_users_from_admin_with_clocks
    render(conn, "indexclocks.json", users: users)
  end

  def count_users_in_team(conn, %{"teamid" => teamid}) do
    IO.inspect(teamid)
    number = Models.count_users_in_team(teamid)
    render(conn, "number.json", number: number)
  end

  def show_by_infos(conn, %{"username" => username, "email" => email}) do
    users = Models.get_users_by_infos!(username, email)
    render(conn, "show.json", users: users)
  end

  #[POST] /api/users/:id
  def show(conn, %{"id" => id}) do
    users = Models.get_user(id)
    render(conn, "show.json", users: users)
    |> Guardian.Plug.current_resource
  end

    #[POST] /api/users/:id
    def nothing(conn) do
      conn
      |> put_status(:ok)
    end

  #[PUT] /api/users/:id
  #?username : String
  #?email : String
  def edit(conn, %{"id" => id} = params) do
    users = Models.get_user(id)

    with {:ok, %Users{} = users} <- Models.update_user(users, params) do
      render(conn, "show.json", users: users)
    end
  end

  #[DELETE] /api/users/:id
  def delete(conn, %{"id" => id}) do
    users = Models.get_user(id)

    with {:ok, %Users{}} <- Models.delete_user(users) do
      send_resp(conn, :no_content, "")
    end
  end
end
