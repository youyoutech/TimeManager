defmodule JsonApiWeb.TeamController do
  use JsonApiWeb, :controller

  alias JsonApi.Models
  alias JsonApi.Models.Team

  action_fallback JsonApiWeb.FallbackController

  def index(conn, _params) do
    teams = Models.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, team_params) do
    with {:ok, %Team{} = team} <- Models.create_team(team_params) do
      conn
      |> put_status(:created)
      |> render("showname.json", team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Models.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id} = params) do
    team = Models.get_team!(id)

    with {:ok, %Team{} = team} <- Models.update_team(team, params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Models.get_team!(id)

    with {:ok, %Team{}} <- Models.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
